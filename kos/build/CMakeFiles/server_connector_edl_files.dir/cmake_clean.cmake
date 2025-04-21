file(REMOVE_RECURSE
  "ServerConnector.edl.h"
  "_headers_/drone_controller/ServerConnector.edl"
  "_headers_/drone_controller/ServerConnector.edl.h"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/server_connector_edl_files.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
