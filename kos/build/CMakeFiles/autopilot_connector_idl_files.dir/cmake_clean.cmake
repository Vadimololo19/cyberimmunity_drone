file(REMOVE_RECURSE
  "AutopilotConnectorInterface.idl.h"
  "_headers_/drone_controller/AutopilotConnectorInterface.idl"
  "_headers_/drone_controller/AutopilotConnectorInterface.idl.h"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/autopilot_connector_idl_files.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
