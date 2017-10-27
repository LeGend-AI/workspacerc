list(APPEND main_cc ${PROJECT_SOURCE_DIR}/src/main.cc)

file(GLOB_RECURSE obj_cc "${PROJECT_SOURCE_DIR}/src/*")
list(REMOVE_ITEM obj_cc ${main_cc})

include_directories("${PROJECT_SOURCE_DIR}/src")
add_library(proj_cc_obj ${obj_cc})
target_link_libraries(proj_cc_obj ${third_party_libs})

if(APPLE)
  set(proj_libs -Wl,-force_load proj_cc_obj)
elseif(UNIX)
  set(proj_libs -Wl,--whole-archive proj_cc_obj -Wl,--no-whole-archive)
elseif(WIN32)
  set(proj_libs proj_cc_obj)
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /WHOLEARCHIVE:proj_cc_obj") 
endif()

foreach(cc ${main_cc})
  get_filename_component(main_name ${cc} NAME_WE)
  add_executable(${main_name} ${cc})
  target_link_libraries(${main_name} ${proj_libs} ${third_party_libs})
endforeach()
