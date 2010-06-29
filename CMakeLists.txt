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
# Disable versioned format files - format plugins will be easier to locate
set(ENABLE_VERSIONED_FORMATS OFF CACHE TYPE BOOL)
# Enable the Avogadro package
set(ENABLE_AVO_PACKAGE ON CACHE TYPE BOOL)

# Make an application bundle
add_definitions(-DAVO_APP_BUNDLE)

# If on Windows then point to the built in DLLs for now (this should be fixed)
if(MSVC)
#  set(LIBXML2_LIBRARIES "${openbabel_SOURCE_DIR}/windows-vc2005/libxml2.lib")
#  set(LIBXML2_INCLUDE_DIR "${openbabel_SOURCE_DIR}/include")
  set(ZLIB_LIBRARY "${openbabel_SOURCE_DIR}/windows-vc2005/zlib1.lib")
  set(ZLIB_INCLUDE_DIR "${openbabel_SOURCE_DIR}/include")
  # Set the plugin directory to the binary directory
  set(OB_PLUGIN_INSTALL_DIR "bin" CACHE PATH "Install dir for plugins" FORCE)
  # Point to the zlib and libxml2 dlls - we should build these
  set(zlib_DIR "${openbabel_SOURCE_DIR}/windows-vc2005")
#  set(libxml2_DIR "${zlib_DIR}")
  set(openbabel_BINDIR "${openbabel_BINARY_DIR}/src")
endif(MSVC)

add_subdirectory(openbabel)

# Set openbabel up for Avogadro now
set(OPENBABEL2_INCLUDE_DIR
  ${openbabel_SOURCE_DIR}/include
  ${openbabel_BINARY_DIR}/include)
set(OPENBABEL2_LIBRARIES openbabel)
set(OPENBABEL2_VERSION_MET TRUE)
set(OPENBABEL2_VERSION "${BABEL_VERSION}")

add_subdirectory(avogadro)

