file(REMOVE_RECURSE
  "ServerConnectorInterface.idl.h"
  "_headers_/drone_controller/ServerConnectorInterface.idl"
  "_headers_/drone_controller/ServerConnectorInterface.idl.h"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/server_connector_idl_files.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
