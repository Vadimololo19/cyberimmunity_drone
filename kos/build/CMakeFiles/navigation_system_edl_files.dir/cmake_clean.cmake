file(REMOVE_RECURSE
  "NavigationSystem.edl.h"
  "_headers_/drone_controller/NavigationSystem.edl"
  "_headers_/drone_controller/NavigationSystem.edl.h"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/navigation_system_edl_files.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
