file(REMOVE_RECURSE
  "LoggerInterface.idl.h"
  "_headers_/drone_controller/LoggerInterface.idl"
  "_headers_/drone_controller/LoggerInterface.idl.h"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/logger_idl_files.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
