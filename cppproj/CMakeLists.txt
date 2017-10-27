cmake_minimum_required(VERSION 3.5)

option(BUILD_THIRD_PARTY "build third party or project" OFF)

if(BUILD_THIRD_PARTY)
  project(third_party C CXX)
else()
  project(proj C CXX)
endif()

enable_testing()
set(CMAKE_CXX_STANDARD 11)
set(POSITION_INDEPENDENT_CODE ON)

set(PROJ_CMAKE_DIR ${PROJECT_SOURCE_DIR}/cmake)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -Wall -o0")

set(THIRD_PARTY_DIR "${PROJECT_SOURCE_DIR}/third_party" CACHE PATH "")

list(APPEND CMAKE_MODULE_PATH ${PROJ_CMAKE_DIR}/third_party)
list(APPEND CMAKE_MODULE_PATH ${PROJ_CMAKE_DIR})
include(third_party)

if(BUILD_THIRD_PARTY)
  add_custom_target(prepare_third_party ALL DEPENDS ${third_party_dependencies})
  set(BUILD_THIRD_PARTY OFF CACHE BOOL "" FORCE)
else()
  include(proj)
endif()
