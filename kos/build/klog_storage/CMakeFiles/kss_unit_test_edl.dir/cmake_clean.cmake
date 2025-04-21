file(REMOVE_RECURSE
  "../_headers_/drone_controller/KSSUnitTest.edl"
  "../_headers_/drone_controller/KSSUnitTest.edl.h"
  "KSSUnitTest.edl.h"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/kss_unit_test_edl.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
