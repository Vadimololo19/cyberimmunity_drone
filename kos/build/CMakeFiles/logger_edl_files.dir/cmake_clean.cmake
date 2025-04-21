file(REMOVE_RECURSE
  "Logger.edl.h"
  "_headers_/drone_controller/Logger.edl"
  "_headers_/drone_controller/Logger.edl.h"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/logger_edl_files.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
