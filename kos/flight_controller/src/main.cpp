/**
 * \file
 * \~English \brief Implementation of the security module FlightController
 * component main loop.
 * \~Russian \brief Реализация основного цикла компонента FlightController
 * модуля безопасности.
 */

#include "../../shared/include/initialization_interface.h"
#include "../../shared/include/ipc_messages_autopilot_connector.h"
#include "../../shared/include/ipc_messages_credential_manager.h"
#include "../../shared/include/ipc_messages_initialization.h"
#include "../../shared/include/ipc_messages_logger.h"
#include "../../shared/include/ipc_messages_navigation_system.h"
#include "../../shared/include/ipc_messages_periphery_controller.h"
#include "../../shared/include/ipc_messages_server_connector.h"
#include "../include/flight_controller.h"

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <thread>
#include <unistd.h>
#include <vector>

/** \cond */
#define RETRY_DELAY_SEC 1
#define RETRY_REQUEST_DELAY_SEC 5
#define FLY_ACCEPT_PERIOD_US 500000

const double THRESHOLD_METERS = 2.0;             // 10 метров допустимого отклонения
const double DEGREES_PER_METER = 1.0 / 111320.0; // Примерно 1 градус = 111320 м
const double THRESHOLD_DEGREES = THRESHOLD_METERS * DEGREES_PER_METER;

int currentWaypointIndex = -1;
int lastReachedWaypointIndex = -1;
bool needNewTarget = true;
bool missionComplete = false;

struct RoutePoint
{
    double latitude;
    double longitude;
    int32_t altitude;
    bool isWaypoint;
};

char boardId[32] = {0};
uint32_t sessionDelay;
std::thread sessionThread;
/** \endcond */

/**
 * \~English Auxiliary procedure. Adds drone ID to request and signs it, sends
 * message to the ATM server and checks the authenticity of the received
 * response.
 * \param[in] method Request to the ATM server. "/api/method" form is expected.
 * \param[out] response Significant part of the response from the server.
 * \param[in] errorMessage Identifier for logging errors.
 * \param[in] delay Delay in seconds before resending the request if an error
 * occurs.
 * \return Returns 1 on success, 0 otherwise.
 * \~Russian Вспомогательная процедура. Снабжает запрос идентификатором дрона,
 * подписывает его, отправляет на сервер ОРВД и проверяет аутентичность
 * полученного ответа.
 */
int sendSignedMessage(char *method, char *response, char *errorMessage,
                      uint8_t delay)
{
    char logBuffer[256] = {0};
    char signature[257] = {0};
    char request[512] = {0};
    if (strstr(method, "?"))
        snprintf(request, 512, "%s&id=%s", method, boardId);
    else
        snprintf(request, 512, "%s?id=%s", method, boardId);

    while (!signMessage(request, signature, 257))
    {
        snprintf(
            logBuffer, 256,
            "Failed to sign %s message at Credential Manager. Trying again in %ds",
            errorMessage, delay);
        logEntry(logBuffer, ENTITY_NAME, LogLevel::LOG_WARNING);
        sleep(delay);
    }
    snprintf(request, 512, "%s&sig=0x%s", request, signature);

    while (!sendRequest(request, response, 4096))
    {
        snprintf(logBuffer, 256,
                 "Failed to send %s request through Server Connector. Trying again "
                 "in %ds",
                 errorMessage, delay);
        logEntry(logBuffer, ENTITY_NAME, LogLevel::LOG_WARNING);
        sleep(delay);
    }
    if (!strcmp(response, "TIMEOUT"))
        return 0;

    uint8_t authenticity = 0;
    while (!checkSignature(response, authenticity) || !authenticity)
    {
        snprintf(logBuffer, 256,
                 "Failed to check signature of %s response. Trying again in %ds",
                 errorMessage, delay);
        logEntry(logBuffer, ENTITY_NAME, LogLevel::LOG_WARNING);
        sleep(delay);
    }

    return 1;
}

/**
 * \~English Procedure that checks the flight status at the ATM server.
 * \~Russian Процедура, запрашивающая статус полёта от сервера ОРВД.
 */
void serverSession()
{
    sleep(sessionDelay);
    char response[4096] = {0};
    while (true)
    {
        sendSignedMessage("/api/flight_info", response, "session", RETRY_DELAY_SEC);
        if (strstr(response, "$Flight -1$"))
        {
            logEntry("Emergency stop request is received. Disabling motors",
                     ENTITY_NAME, LogLevel::LOG_INFO);
            if (!enableBuzzer())
                logEntry("Failed to enable buzzer", ENTITY_NAME, LogLevel::LOG_WARNING);
            while (!setKillSwitch(false))
            {
                logEntry("Failed to forbid motor usage. Trying again in 1s",
                         ENTITY_NAME, LogLevel::LOG_WARNING);
                sleep(1);
            }
        }

        char receivedHash[65] = {0};
        char *calculatedHash = getNoFlightAreasHash();
        parseNoFlightAreasHash(response, receivedHash, 65);
        if (strcmp(receivedHash, calculatedHash))
        {
            logEntry("No-flight areas on the server were updated", ENTITY_NAME,
                     LogLevel::LOG_INFO);
            char hash[65] = {0};
            char responseDelta[4096] = {0};
            strcpy(hash, receivedHash);
            sendSignedMessage("/api/get_forbidden_zones_delta", responseDelta,
                              "no-flight areas", RETRY_DELAY_SEC);
            int successful = updateNoFlightAreas(responseDelta);
            if (successful)
            {
                calculatedHash = getNoFlightAreasHash();
                successful = !strcmp(hash, calculatedHash);
            }
            if (!successful)
            {
                logEntry("Completely redownloading no-flight areas", ENTITY_NAME,
                         LogLevel::LOG_INFO);
                deleteNoFlightAreas();
                sendSignedMessage("/api/get_all_forbidden_zones", responseDelta,
                                  "no-flight areas", RETRY_DELAY_SEC);
                loadNoFlightAreas(responseDelta);
            }
            printNoFlightAreas();
        }

        sessionDelay = parseDelay(strstr(response, "$Delay "));
        sleep(sessionDelay);
    }
}

/**
 * \~English Auxiliary procedure. Asks the ATM server to approve a new mission
 * and parses its response.
 * \~Russian Вспомогательная процедура. Просит у сервера ОРВД одобрения новой
 * миссии и обрабатывает ответ.
 */
int askForMissionApproval(char *mission, int &result)
{
    int requestSize = 512 + strlen(mission);
    char signature[257] = {0};
    char *request = (char *)malloc(requestSize);
    snprintf(request, requestSize, "/api/nmission?id=%s&mission=%s", boardId,
             mission);

    if (!signMessage(request, signature, 257))
    {
        logEntry("Failed to sign New Mission request at Credential Manager",
                 ENTITY_NAME, LogLevel::LOG_WARNING);
        free(request);
        return 0;
    }
    snprintf(request, 512, "%s&sig=0x%s", request, signature);

    char response[4096] = {0};
    if (!sendRequest(request, response, 4096))
    {
        logEntry("Failed to send New Mission request through Server Connector",
                 ENTITY_NAME, LogLevel::LOG_WARNING);
        free(request);
        return 0;
    }
    free(request);

    uint8_t authenticity = 0;
    while (!checkSignature(response, authenticity) || !authenticity)
    {
        logEntry("Failed to check signature of New Mission response", ENTITY_NAME,
                 LogLevel::LOG_WARNING);
        return 0;
    }

    if (strstr(response, "$Approve 0#") != NULL)
        result = 1;
    else if (strstr(response, "$Approve 1#") != NULL)
        result = 0;
    else
    {
        logEntry("Failed to parse server response on New Mission request",
                 ENTITY_NAME, LogLevel::LOG_WARNING);
        return 0;
    }

    return 1;
}

void logMissionCommands(const MissionCommand *commands, int count)
{
    logEntry("========== MISSION COMMANDS START ==========", ENTITY_NAME,
             LogLevel::LOG_INFO);
    char logMsg[512];
    snprintf(logMsg, sizeof(logMsg), "Loaded %d mission commands:", count);
    logEntry(logMsg, ENTITY_NAME, LogLevel::LOG_INFO);

    for (int i = 0; i < count; i++)
    {
        if (commands[i].type == CommandType::WAYPOINT &&
            commands[i].type == CommandType::TAKEOFF &&
            commands[i].type == CommandType::LAND)
        {
            snprintf(logMsg, sizeof(logMsg), "Cmd %d: WAYPOINT (%.6f, %.6f) alt=%d",
                     i, commands[i].content.waypoint.latitude / 1e7,
                     commands[i].content.waypoint.longitude / 1e7,
                     commands[i].content.waypoint.altitude);
            logEntry(logMsg, ENTITY_NAME, LogLevel::LOG_INFO);
        }
        else
        {
            snprintf(logMsg, sizeof(logMsg), "Cmd %d: Type %d", i,
                     static_cast<int>(commands[i].type));
            logEntry(logMsg, ENTITY_NAME, LogLevel::LOG_DEBUG);
        }
    }
    logEntry("=========== MISSION COMMANDS END ===========", ENTITY_NAME,
             LogLevel::LOG_INFO);
}

bool isAtPoint(double targetLat, double targetLon, double currentLat,
               double currentLon)
{
    double distance =
        sqrt(pow(targetLat - currentLat, 2) + pow(targetLon - currentLon, 2));
    return distance <= THRESHOLD_DEGREES;
}


/**
 * \~English Security module main loop.
 * \~Russian Основной цикл модуля безопасности.
 */
int main(void)
{
    char logBuffer[256] = {0};
    char responseBuffer[4096] = {0};

    while (!waitForInit("logger_connection", "Logger"))
    {
        snprintf(logBuffer, 256,
                 "Failed to receive initialization notification from Logger. "
                 "Trying again in %ds",
                 RETRY_DELAY_SEC);
        logEntry(logBuffer, ENTITY_NAME, LogLevel::LOG_WARNING);
        sleep(RETRY_DELAY_SEC);
    }
    while (
        !waitForInit("periphery_controller_connection", "PeripheryController"))
    {
        snprintf(logBuffer, 256,
                 "Failed to receive initialization notification from Periphery "
                 "Controller. Trying again in %ds",
                 RETRY_DELAY_SEC);
        logEntry(logBuffer, ENTITY_NAME, LogLevel::LOG_WARNING);
        sleep(RETRY_DELAY_SEC);
    }
    while (!waitForInit("autopilot_connector_connection", "AutopilotConnector"))
    {
        snprintf(logBuffer, 256,
                 "Failed to receive initialization notification from Autopilot "
                 "Connector. Trying again in %ds",
                 RETRY_DELAY_SEC);
        logEntry(logBuffer, ENTITY_NAME, LogLevel::LOG_WARNING);
        sleep(RETRY_DELAY_SEC);
    }
    while (!waitForInit("navigation_system_connection", "NavigationSystem"))
    {
        snprintf(logBuffer, 256,
                 "Failed to receive initialization notification from Navigation "
                 "System. Trying again in %ds",
                 RETRY_DELAY_SEC);
        logEntry(logBuffer, ENTITY_NAME, LogLevel::LOG_WARNING);
        sleep(RETRY_DELAY_SEC);
    }
    while (!waitForInit("server_connector_connection", "ServerConnector"))
    {
        snprintf(logBuffer, 256,
                 "Failed to receive initialization notification from Server "
                 "Connector. Trying again in %ds",
                 RETRY_DELAY_SEC);
        logEntry(logBuffer, ENTITY_NAME, LogLevel::LOG_WARNING);
        sleep(RETRY_DELAY_SEC);
    }
    while (!waitForInit("credential_manager_connection", "CredentialManager"))
    {
        snprintf(logBuffer, 256,
                 "Failed to receive initialization notification from Credential "
                 "Manager. Trying again in %ds",
                 RETRY_DELAY_SEC);
        logEntry(logBuffer, ENTITY_NAME, LogLevel::LOG_WARNING);
        sleep(RETRY_DELAY_SEC);
    }

    while (!getBoardId(boardId))
    {
        logEntry("Failed to get board ID from ServerConnector. Trying again in 1s",
                 ENTITY_NAME, LogLevel::LOG_WARNING);
        sleep(1);
    }
    snprintf(logBuffer, 256, "Board '%s' is initialized", boardId);
    logEntry(logBuffer, ENTITY_NAME, LogLevel::LOG_INFO);

    if (!enableBuzzer())
        logEntry("Failed to enable buzzer at Periphery Controller", ENTITY_NAME,
                 LogLevel::LOG_WARNING);

    sendSignedMessage("/api/auth", responseBuffer, "authentication",
                      RETRY_DELAY_SEC);
    logEntry("Successfully authenticated on the server", ENTITY_NAME,
             LogLevel::LOG_INFO);

    while (true)
    {
        if (sendSignedMessage("/api/fmission_kos", responseBuffer, "mission",
                              RETRY_DELAY_SEC) &&
            loadMission(responseBuffer))
        {
            logEntry("Successfully received mission from the server", ENTITY_NAME,
                     LogLevel::LOG_INFO);
            printMission();
            break;
        }
        sleep(RETRY_REQUEST_DELAY_SEC);
    }

    while (true)
    {
        if (sendSignedMessage("/api/get_all_forbidden_zones", responseBuffer,
                              "no-flight areas", RETRY_DELAY_SEC) &&
            loadNoFlightAreas(responseBuffer))
        {
            logEntry("Successfully received no-flight areas from the server",
                     ENTITY_NAME, LogLevel::LOG_INFO);
            printNoFlightAreas();
            break;
        }
        sleep(RETRY_REQUEST_DELAY_SEC);
    }

    logEntry("Ready to arm", ENTITY_NAME, LogLevel::LOG_INFO);
    while (true)
    {
        while (!waitForArmRequest())
        {
            snprintf(logBuffer, 256,
                     "Failed to receive an arm request from Autopilot Connector. "
                     "Trying again in %ds",
                     RETRY_DELAY_SEC);
            logEntry(logBuffer, ENTITY_NAME, LogLevel::LOG_WARNING);
            sleep(RETRY_DELAY_SEC);
        }
        logEntry("Received arm request. Notifying the server", ENTITY_NAME,
                 LogLevel::LOG_INFO);

        sendSignedMessage("/api/arm", responseBuffer, "arm", RETRY_DELAY_SEC);

        if (strstr(responseBuffer, "$Arm 0$"))
        {
            logEntry("Arm is permitted", ENTITY_NAME, LogLevel::LOG_INFO);
            while (!setKillSwitch(true))
            {
                snprintf(logBuffer, 256,
                         "Failed to permit motor usage at Periphery Controller. Trying "
                         "again in %ds",
                         RETRY_DELAY_SEC);
                logEntry(logBuffer, ENTITY_NAME, LogLevel::LOG_WARNING);
                sleep(RETRY_DELAY_SEC);
            }
            if (!permitArm())
                logEntry("Failed to permit arm through Autopilot Connector",
                         ENTITY_NAME, LogLevel::LOG_WARNING);
            sessionDelay = parseDelay(strstr(responseBuffer, "$Delay "));
            sessionThread = std::thread(serverSession);
            break;
        }
        else if (strstr(responseBuffer, "$Arm 1$"))
        {
            logEntry("Arm is forbidden", ENTITY_NAME, LogLevel::LOG_INFO);
            if (!forbidArm())
                logEntry("Failed to forbid arm through Autopilot Connector",
                         ENTITY_NAME, LogLevel::LOG_WARNING);
        }
        else
        {
            logEntry("Failed to parse server response", ENTITY_NAME,
                     LogLevel::LOG_WARNING);
        }
        logEntry(
            "Arm was not allowed. Waiting for another arm request from autopilot",
            ENTITY_NAME, LogLevel::LOG_WARNING);
    }

    // start_cringe
    setCargoLock(0);
    logEntry("Starting flight control loop", ENTITY_NAME, LogLevel::LOG_WARNING);

    int missionCount = 0;
    MissionCommand *missionCommands = getMissionCommands(missionCount);

    logMissionCommands(missionCommands, missionCount);
    bool isLanded = false;

    while (!missionComplete)
    {
        bool flag = sendSignedMessage("/api/flight_info", responseBuffer, "session", RETRY_DELAY_SEC);
        if(!flag && !isLanded){
            logEntry("Failed to connect to the ORVD", ENTITY_NAME, LogLevel::LOG_WARNING);
            pauseFlight();
            isLanded = true;
        }
        else if(flag && isLanded) {
            isLanded = false;
            resumeFlight();
        }

        int32_t lat, lon, alt;
        if (!getCoords(lat, lon, alt))
        {
            logEntry("Failed to get coordinates", ENTITY_NAME, LogLevel::LOG_WARNING);
            sleep(1);
            continue;
        }

        double currentLat = lat / 1e7;
        double currentLon = lon / 1e7;

        if (needNewTarget)
        {
            bool found = false;
            for (int i = currentWaypointIndex + 1; i < missionCount; i++)
            {
                if (missionCommands[i].type == CommandType::WAYPOINT ||
                    missionCommands[i].type == CommandType::DELAY)
                {
                    char logMsg[256];
                    snprintf(logMsg, sizeof(logMsg), "command %d ", currentWaypointIndex);
                    logEntry(logMsg, ENTITY_NAME, LogLevel::LOG_INFO);
                    currentWaypointIndex = i;
                    found = true;
                    break;
                }
            }

            if (!found)
            {
                logEntry("Mission complete - no more commands", ENTITY_NAME,
                         LogLevel::LOG_INFO);
                missionComplete = true;
                break;
            }

            needNewTarget = false;

            if (missionCommands[currentWaypointIndex].type == CommandType::DELAY)
            {
                char logMsg[256];
                snprintf(logMsg, sizeof(logMsg),
                         "Executing DELAY command for %d seconds",
                         missionCommands[currentWaypointIndex].content.delay.delay);
                logEntry(logMsg, ENTITY_NAME, LogLevel::LOG_INFO);
                if (missionCommands[currentWaypointIndex + 1].type == CommandType::SET_SERVO)
                {
                    setCargoLock(1);
                }
                sleep(missionCommands[currentWaypointIndex].content.delay.delay);
                needNewTarget = true;
                continue;
            }
        }
        if (missionCommands[currentWaypointIndex + 1].type ==
            CommandType::SET_SERVO)
        {
            setCargoLock(1);
            logEntry("Cargo lock disabled, CARGO DROPPED", ENTITY_NAME,
                     LogLevel::LOG_INFO);
        }

        float speed;
        int32_t speedLimit = 50;
        int32_t speedThreshold = 5;
        getEstimatedSpeed(speed);
        snprintf(logBuffer, 256, "Speed: %f", speed);
        logEntry(logBuffer, ENTITY_NAME, LogLevel::LOG_INFO);

        if ((speed > speedLimit + speedThreshold) ||
            (speed < speedLimit - speedThreshold))
        {
            changeSpeed(speedLimit);
            logEntry("Speed changed", ENTITY_NAME, LogLevel::LOG_INFO);
        }
        if (missionCommands[currentWaypointIndex].type == CommandType::WAYPOINT)
        {
            RoutePoint targetWaypoint = {
                missionCommands[currentWaypointIndex].content.waypoint.latitude / 1e7,
                missionCommands[currentWaypointIndex].content.waypoint.longitude /
                    1e7,
                missionCommands[currentWaypointIndex].content.waypoint.altitude,
                true};

            char logMsg[256];
            snprintf(logMsg, sizeof(logMsg),
                     "Current target: waypoint %d at (%.6f, %.6f) alt=%d",
                     currentWaypointIndex, targetWaypoint.latitude,
                     targetWaypoint.longitude, targetWaypoint.altitude);
            logEntry(logMsg, ENTITY_NAME, LogLevel::LOG_DEBUG);

            if (isAtPoint(targetWaypoint.latitude, targetWaypoint.longitude,
                          currentLat, currentLon))
            {
                snprintf(logMsg, sizeof(logMsg), "Reached waypoint %d at (%.6f, %.6f)",
                         currentWaypointIndex, targetWaypoint.latitude,
                         targetWaypoint.longitude);
                logEntry(logMsg, ENTITY_NAME, LogLevel::LOG_INFO);

                if (currentWaypointIndex == missionCount - 1)
                {
                    logEntry("Final waypoint reached. Mission complete.", ENTITY_NAME,
                             LogLevel::LOG_INFO);
                    abortMission();
                    setKillSwitch(0);
                    missionComplete = true;
                    break;
                }

                sleep(5);

                needNewTarget = true;
                continue;
            }
            else
            {
                double distance = sqrt(pow(targetWaypoint.latitude - currentLat, 2) +
                                       pow(targetWaypoint.longitude - currentLon, 2));

                if (distance > THRESHOLD_DEGREES)
                {
                    snprintf(logMsg, sizeof(logMsg),
                             "Too far from target (%.2fm), redirecting to waypoint %d",
                             distance / DEGREES_PER_METER, currentWaypointIndex);
                    logEntry(logMsg, ENTITY_NAME, LogLevel::LOG_WARNING);

                    if (!changeWaypoint(targetWaypoint.latitude * 1e7,
                                        targetWaypoint.longitude * 1e7,
                                        targetWaypoint.altitude))
                    {
                        logEntry("Failed to change waypoint", ENTITY_NAME,
                                 LogLevel::LOG_ERROR);
                    }
                }
            }
        }

        usleep(FLY_ACCEPT_PERIOD_US);
    }

    return EXIT_SUCCESS;
}

