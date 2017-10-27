if (NOT WIN32)
  find_package(Threads)
endif()

include(googletest)
include(glog)
include(gflags)

set(third_party_libs
    ${GLOG_STATIC_LIBRARIES}
    ${GFLAGS_STATIC_LIBRARIES}
    ${GOOGLETEST_STATIC_LIBRARIES}
    ${GOOGLEMOCK_STATIC_LIBRARIES}
)

if(WIN32)
  # static gflags lib requires "PathMatchSpecA" defined in "ShLwApi.Lib"
  list(APPEND third_party_libs "ShLwApi.Lib")
  list(APPEND third_party_libs "Ws2_32.lib")
endif()

set(third_party_dependencies
  gflags_copy_headers_to_destination
  gflags_copy_libs_to_destination
  glog_copy_headers_to_destination
  glog_copy_libs_to_destination
  googletest_copy_headers_to_destination
  googletest_copy_libs_to_destination
  googlemock_copy_headers_to_destination
  googlemock_copy_libs_to_destination
)

include_directories(
    ${GFLAGS_INCLUDE_DIR}
    ${GLOG_INCLUDE_DIR}
    ${GOOGLETEST_INCLUDE_DIR}
    ${GOOGLEMOCK_INCLUDE_DIR}
)
