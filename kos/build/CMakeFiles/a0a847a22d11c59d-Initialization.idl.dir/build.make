# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.29

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/toolchain/bin/cmake

# The command to remove a file.
RM = /opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/toolchain/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /mnt/kos

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /mnt/kos/build

# Utility rule file for a0a847a22d11c59d-Initialization.idl.

# Include any custom commands dependencies for this target.
include CMakeFiles/a0a847a22d11c59d-Initialization.idl.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/a0a847a22d11c59d-Initialization.idl.dir/progress.make

CMakeFiles/a0a847a22d11c59d-Initialization.idl: _headers_/drone_controller/Initialization.idl

_headers_/drone_controller/Initialization.idl: /mnt/kos/resources/Initialization.idl
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/mnt/kos/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating _headers_/drone_controller/Initialization.idl"
	/opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/toolchain/bin/cmake -E copy /mnt/kos/resources/Initialization.idl /mnt/kos/build/_headers_/DroneController/../drone_controller/Initialization.idl

a0a847a22d11c59d-Initialization.idl: CMakeFiles/a0a847a22d11c59d-Initialization.idl
a0a847a22d11c59d-Initialization.idl: _headers_/drone_controller/Initialization.idl
a0a847a22d11c59d-Initialization.idl: CMakeFiles/a0a847a22d11c59d-Initialization.idl.dir/build.make
.PHONY : a0a847a22d11c59d-Initialization.idl

# Rule to build all files generated by this target.
CMakeFiles/a0a847a22d11c59d-Initialization.idl.dir/build: a0a847a22d11c59d-Initialization.idl
.PHONY : CMakeFiles/a0a847a22d11c59d-Initialization.idl.dir/build

CMakeFiles/a0a847a22d11c59d-Initialization.idl.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/a0a847a22d11c59d-Initialization.idl.dir/cmake_clean.cmake
.PHONY : CMakeFiles/a0a847a22d11c59d-Initialization.idl.dir/clean

CMakeFiles/a0a847a22d11c59d-Initialization.idl.dir/depend:
	cd /mnt/kos/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /mnt/kos /mnt/kos /mnt/kos/build /mnt/kos/build /mnt/kos/build/CMakeFiles/a0a847a22d11c59d-Initialization.idl.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/a0a847a22d11c59d-Initialization.idl.dir/depend

