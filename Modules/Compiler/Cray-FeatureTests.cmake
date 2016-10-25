if(__COMPILER_Cray_FEATURETESTS)
  return()
endif()
set(__COMPILER_Cray_FEATURETESTS 1)

# Build a version test macro from components
macro(_Cray_get_version_test test_var comp_ver)
  if("${comp_ver}" MATCHES "([0-9]+)\\.([0-9]+)")
    set(${test_var} "_RELEASE_MAJOR > ${CMAKE_MATCH_1} || (_RELEASE_MAJOR == ${CMAKE_MATCH_1} && _RELEASE_MINOR >= ${CMAKE_MATCH_2})")
  elseif("${comp_ver}" MATCHES "([0-9]+)")
    set(${test_var} "_RELEASE_MAJOR >= ${CMAKE_MATCH_1}")
  endif()
endmacro()

# Set the appropriate feature support macro given a minimum compiler version
macro(_Cray_set_feature_support feature ver)
  if(${ver} EQUAL 0)
    set(_cmake_feature_test_${feature} 0)
  elseif(${ver} EQUAL 1)
    set(_cmake_feature_test_${feature} 1)
  else()
    _Cray_get_version_test(_cmake_feature_test_${feature} ${ver})
  endif()
endmacro()
