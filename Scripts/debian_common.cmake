# Client maintainer: paul@paulnovo.us
# This build is as close as possible to Debian's standard build, intended
# to identify integration issues early in the release cycle.  This file
# factors the common Debian settings.
#
# CTEST_BUILD_NAME must be set prior to including this file
#
# Differences from Debian's build:
# 1. CMAKE_SKIP_RPATH is OFF here because otherwise can't find shared libs
#      (shared libs need to be ON for wrapping)

set(CTEST_BUILD_CONFIGURATION Release)
set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
set(dashboard_root_name "MyTests")
set(dashboard_git_url "http://itk.org/ITK.git")

# 2011-09-01: Disable System TIFF, since ITK now requires TIFF 4.0
# (http://www.itk.org/mailman/private/insight-developers/2011-August/020078.html)
# while Debian ships v3.

macro(dashboard_hook_init)
  set( dashboard_cache "
    CMAKE_VERBOSE_MAKEFILE:BOOL=ON
    BUILD_EXAMPLES:BOOL=ON
    BUILD_SHARED_LIBS:BOOL=ON
    BUILD_TESTING:BOOL=ON 
    BUILD_DOXYGEN:BOOL=OFF 
    CMAKE_SKIP_RPATH:BOOL=OFF
    ITK_USE_SYSTEM_GDCM:BOOL=ON
    ITK_USE_SYSTEM_JPEG:BOOL=ON 
    ITK_USE_SYSTEM_PNG:BOOL=ON 
    ITK_USE_SYSTEM_TIFF:BOOL=OFF 
    ITK_USE_SYSTEM_ZLIB:BOOL=ON 
    ITK_USE_SYSTEM_VXL:BOOL=OFF 
    USE_FFTWD:BOOL=ON 
    USE_FFTWF:BOOL=ON 
    ITK_USE_CONCEPT_CHECKING:BOOL=ON 
    ITK_USE_STRICT_CONCEPT_CHECKING:BOOL=ON
    ${EXTRA_CACHE_SETTINGS}
    "
    )
endmacro(dashboard_hook_init)

# Sends this file as a note.  Hint from Brian Helba @ Kitware
list(APPEND CTEST_NOTES_FILES "${CMAKE_CURRENT_LIST_FILE}" )

include(${CTEST_SCRIPT_DIRECTORY}/itk_common.cmake)

