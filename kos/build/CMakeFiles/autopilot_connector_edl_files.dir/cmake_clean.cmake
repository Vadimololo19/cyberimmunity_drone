file(REMOVE_RECURSE
  "AutopilotConnector.edl.h"
  "_headers_/drone_controller/AutopilotConnector.edl"
  "_headers_/drone_controller/AutopilotConnector.edl.h"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/autopilot_connector_edl_files.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
