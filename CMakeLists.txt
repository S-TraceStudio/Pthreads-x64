cmake_minimum_required(VERSION 3.10)

# set the project name
project(pthread-x64 VERSION 1.0)

# control where the static and shared libraries are built so that on windows
# we don't need to tinker with the path to run the executable
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")

option(BUILD_SHARED_LIBS "Build using shared libraries" OFF)

# add the Library
set(HEADER_FILES headers/*.h )
add_Library(pthread-x64 sources/*.c )
target_include_directories(pthread-x64 PRIVATE ${HEADER_FILES})

# add version number
configure_file(headers/pthread.h.in pthread.h)
target_include_directories(pthread-x64 PUBLIC "${PROJECT_BINARY_DIR}"  )


# specify the C standard
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED True)
set_target_properties(pthread-x64  PROPERTIES LINKER_LANGUAGE C)

# install
install(FILES headers/*.h DESTINATION include)
install(TARGETS pthread-x64 DESTINATION lib)
