file(REMOVE_RECURSE
  "PeripheryController.edl.h"
  "_headers_/drone_controller/PeripheryController.edl"
  "_headers_/drone_controller/PeripheryController.edl.h"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/periphery_controller_edl_files.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
