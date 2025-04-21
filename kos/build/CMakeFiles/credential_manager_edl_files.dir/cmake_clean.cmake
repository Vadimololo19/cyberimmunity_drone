file(REMOVE_RECURSE
  "CredentialManager.edl.h"
  "_headers_/drone_controller/CredentialManager.edl"
  "_headers_/drone_controller/CredentialManager.edl.h"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/credential_manager_edl_files.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
