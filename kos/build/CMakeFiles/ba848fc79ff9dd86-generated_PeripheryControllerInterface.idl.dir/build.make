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

# Utility rule file for ba848fc79ff9dd86-generated_PeripheryControllerInterface.idl.

# Include any custom commands dependencies for this target.
include CMakeFiles/ba848fc79ff9dd86-generated_PeripheryControllerInterface.idl.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/ba848fc79ff9dd86-generated_PeripheryControllerInterface.idl.dir/progress.make

CMakeFiles/ba848fc79ff9dd86-generated_PeripheryControllerInterface.idl: PeripheryControllerInterface.idl.h
CMakeFiles/ba848fc79ff9dd86-generated_PeripheryControllerInterface.idl: _headers_/drone_controller/PeripheryControllerInterface.idl.h

PeripheryControllerInterface.idl.h: _headers_/drone_controller/PeripheryControllerInterface.idl
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/mnt/kos/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating PeripheryControllerInterface.idl.h"
	/opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/toolchain/bin/nk-gen-c -I /mnt/kos/build/_headers_ -I /mnt/kos/build/_headers_/DroneController/.. -I /mnt/kos/build/../install/include -I /opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/sysroot-aarch64-kos/include -I /opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/toolchain/aarch64-kos/include -I /usr/local/include -I /usr/include -I //include -I /opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/toolchain/include -I /usr/X11R6/include -I /usr/pkg/include -I /opt/include -P /opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/sysroot-aarch64-kos/include/system.platform -I /mnt/kos/build/_headers_/DroneController/../drone_controller /mnt/kos/build/_headers_/DroneController/../drone_controller/PeripheryControllerInterface.idl -o /mnt/kos/build

_headers_/drone_controller/PeripheryControllerInterface.idl.h: PeripheryControllerInterface.idl.h
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/mnt/kos/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Generating _headers_/drone_controller/PeripheryControllerInterface.idl.h"
	/opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/toolchain/bin/cmake -E copy /mnt/kos/build/PeripheryControllerInterface.idl.h /mnt/kos/build/_headers_/DroneController/../drone_controller/PeripheryControllerInterface.idl.h

_headers_/drone_controller/PeripheryControllerInterface.idl: /mnt/kos/resources/PeripheryControllerInterface.idl
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/mnt/kos/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Generating _headers_/drone_controller/PeripheryControllerInterface.idl"
	/opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/toolchain/bin/cmake -E copy /mnt/kos/resources/PeripheryControllerInterface.idl /mnt/kos/build/_headers_/DroneController/../drone_controller/PeripheryControllerInterface.idl

ba848fc79ff9dd86-generated_PeripheryControllerInterface.idl: CMakeFiles/ba848fc79ff9dd86-generated_PeripheryControllerInterface.idl
ba848fc79ff9dd86-generated_PeripheryControllerInterface.idl: PeripheryControllerInterface.idl.h
ba848fc79ff9dd86-generated_PeripheryControllerInterface.idl: _headers_/drone_controller/PeripheryControllerInterface.idl
ba848fc79ff9dd86-generated_PeripheryControllerInterface.idl: _headers_/drone_controller/PeripheryControllerInterface.idl.h
ba848fc79ff9dd86-generated_PeripheryControllerInterface.idl: CMakeFiles/ba848fc79ff9dd86-generated_PeripheryControllerInterface.idl.dir/build.make
.PHONY : ba848fc79ff9dd86-generated_PeripheryControllerInterface.idl

# Rule to build all files generated by this target.
CMakeFiles/ba848fc79ff9dd86-generated_PeripheryControllerInterface.idl.dir/build: ba848fc79ff9dd86-generated_PeripheryControllerInterface.idl
.PHONY : CMakeFiles/ba848fc79ff9dd86-generated_PeripheryControllerInterface.idl.dir/build

CMakeFiles/ba848fc79ff9dd86-generated_PeripheryControllerInterface.idl.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/ba848fc79ff9dd86-generated_PeripheryControllerInterface.idl.dir/cmake_clean.cmake
.PHONY : CMakeFiles/ba848fc79ff9dd86-generated_PeripheryControllerInterface.idl.dir/clean

CMakeFiles/ba848fc79ff9dd86-generated_PeripheryControllerInterface.idl.dir/depend:
	cd /mnt/kos/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /mnt/kos /mnt/kos /mnt/kos/build /mnt/kos/build /mnt/kos/build/CMakeFiles/ba848fc79ff9dd86-generated_PeripheryControllerInterface.idl.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/ba848fc79ff9dd86-generated_PeripheryControllerInterface.idl.dir/depend

