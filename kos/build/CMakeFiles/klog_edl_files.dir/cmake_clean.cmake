file(REMOVE_RECURSE
  "KlogEntity.edl.h"
  "_headers_/drone_controller/KlogEntity.edl"
  "_headers_/drone_controller/KlogEntity.edl.h"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/klog_edl_files.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
