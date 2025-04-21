file(REMOVE_RECURSE
  "Initialization.idl.h"
  "_headers_/drone_controller/Initialization.idl"
  "_headers_/drone_controller/Initialization.idl.h"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/initialization_idl_files.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
