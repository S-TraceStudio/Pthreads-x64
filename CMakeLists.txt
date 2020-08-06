cmake_minimum_required(VERSION 3.12)

# set the project name
project(pthreads-x64 VERSION 1.0)

# control where the static and shared libraries are built so that on windows
# we don't need to tinker with the path to run the executable
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")

option(BUILD_SHARED_LIBS "Build using shared libraries" OFF)

# add the Library
# set(HEADER_FILES headers/*.h )
# target_include_directories(pthreads-x64 PRIVATE headers/)

include_directories(headers)
file(GLOB HEADER_FILES "headers/*.h" )
#file(GLOB SOURCES_FILES "sources/*.c" )
set(SOURCES_FILES sources/pthread.c )

add_Library(pthreads-x64 ${SOURCES_FILES} )
target_include_directories(pthreads-x64 PRIVATE ${HEADER_FILES})

# add version number
configure_file(headers/pthread.h.in pthread.h)
target_include_directories(pthreads-x64 PUBLIC "${PROJECT_BINARY_DIR}"  )

# specify the C standard
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED True)
set_target_properties(pthreads-x64  PROPERTIES LINKER_LANGUAGE C)

#preprocessor directives
add_compile_definitions(__CLEANUP_C)
add_compile_definitions(_TIMESPEC_DEFINED)
add_compile_definitions(PTW32_STATIC_LIB)
add_compile_definitions(_USRDLL)
add_compile_definitions(PTW32_BUILD)

add_compile_definitions(WIN32)
add_compile_definitions(_WINDOWS)

#target_compile_definitions(Debug PRIVATE _DEBUG)
#target_compile_definitions(Release PRIVATE NDEBUG)

# install
install(FILES ${HEADER_FILES} DESTINATION include)
install(TARGETS pthreads-x64 DESTINATION lib)
