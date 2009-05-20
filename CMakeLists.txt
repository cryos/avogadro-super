project(AvogadroOpenBabel)

cmake_minimum_required(VERSION 2.6)

cmake_policy(SET CMP0009 NEW)
cmake_policy(SET CMP0011 NEW)

set(Avogadro_VERSION "0.9")

# Some rpath handling for Linux and Mac
option(ENABLE_RPATH "Enable rpath support on Linux and Mac" ON)
if(UNIX AND ENABLE_RPATH)
  message(STATUS "RPath support enabled for installed binaries and libraries")
  set(CMAKE_SKIP_BUILD_RPATH FALSE)
  set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
  set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
  if(APPLE)
    # Funky path logic in order to get the Avogadro application bundle working
    set(CMAKE_BUNDLE_LOCATION "/Applications")
    set(CMAKE_BUNDLE_NAME "Avogadro")
    set(CMAKE_INSTALL_PREFIX "/Applications/${CMAKE_BUNDLE_NAME}.app/Contents")
    set(CMAKE_INSTALL_NAME_DIR "@executable_path/../lib")
  endif(APPLE)
endif(UNIX AND ENABLE_RPATH)

# Enable embedded OpenBabel so that Avogadro builds against the compiled lib
set(EMBED_OPENBABEL ON CACHE TYPE BOOL)
# Enable the Avogadro package
set(ENABLE_AVO_PACKAGE ON CACHE TYPE BOOL)

# If on Apple define the MAC_BUNDLE variable so that OpenBabel env variables
# can be injected into the running process
if(APPLE)
  add_definitions(-DAVO_APP_BUNDLE)
endif(APPLE)

add_subdirectory(openbabel)
add_subdirectory(avogadro)

