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

# Utility rule file for kos-image_FOR_STRIP.

# Include any custom commands dependencies for this target.
include einit/drone_controller/CMakeFiles/kos-image_FOR_STRIP.dir/compiler_depend.make

# Include the progress variables for this target.
include einit/drone_controller/CMakeFiles/kos-image_FOR_STRIP.dir/progress.make

kos-image_FOR_STRIP: einit/drone_controller/CMakeFiles/kos-image_FOR_STRIP.dir/build.make
.PHONY : kos-image_FOR_STRIP

# Rule to build all files generated by this target.
einit/drone_controller/CMakeFiles/kos-image_FOR_STRIP.dir/build: kos-image_FOR_STRIP
.PHONY : einit/drone_controller/CMakeFiles/kos-image_FOR_STRIP.dir/build

einit/drone_controller/CMakeFiles/kos-image_FOR_STRIP.dir/clean:
	cd /mnt/kos/build/einit/drone_controller && $(CMAKE_COMMAND) -P CMakeFiles/kos-image_FOR_STRIP.dir/cmake_clean.cmake
.PHONY : einit/drone_controller/CMakeFiles/kos-image_FOR_STRIP.dir/clean

einit/drone_controller/CMakeFiles/kos-image_FOR_STRIP.dir/depend:
	cd /mnt/kos/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /mnt/kos /mnt/kos/einit/drone_controller /mnt/kos/build /mnt/kos/build/einit/drone_controller /mnt/kos/build/einit/drone_controller/CMakeFiles/kos-image_FOR_STRIP.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : einit/drone_controller/CMakeFiles/kos-image_FOR_STRIP.dir/depend

