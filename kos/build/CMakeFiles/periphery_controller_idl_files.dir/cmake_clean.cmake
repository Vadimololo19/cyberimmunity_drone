file(REMOVE_RECURSE
  "PeripheryControllerInterface.idl.h"
  "_headers_/drone_controller/PeripheryControllerInterface.idl"
  "_headers_/drone_controller/PeripheryControllerInterface.idl.h"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/periphery_controller_idl_files.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
