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

# Include any dependencies generated for this target.
include einit/drone_controller/CMakeFiles/EinitHw.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include einit/drone_controller/CMakeFiles/EinitHw.dir/compiler_depend.make

# Include the progress variables for this target.
include einit/drone_controller/CMakeFiles/EinitHw.dir/progress.make

# Include the compile flags for this target's objects.
include einit/drone_controller/CMakeFiles/EinitHw.dir/flags.make

einit/drone_controller/EinitHw-kss/EinitHw.c: einit/drone_controller/EinitHw-kss/init.yaml
einit/drone_controller/EinitHw-kss/EinitHw.c: /opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/sysroot-aarch64-kos/bin/bsp_hw
einit/drone_controller/EinitHw-kss/EinitHw.c: /opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/sysroot-aarch64-kos/bin/uart_hw
einit/drone_controller/EinitHw-kss/EinitHw.c: /opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/sysroot-aarch64-kos/bin/i2c_hw
einit/drone_controller/EinitHw-kss/EinitHw.c: /opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/sysroot-aarch64-kos/bin/gpio_hw
einit/drone_controller/EinitHw-kss/EinitHw.c: /opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/sysroot-aarch64-kos/bin/wpa_supplicant
einit/drone_controller/EinitHw-kss/EinitHw.c: /opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/sysroot-aarch64-kos/bin/VfsSdCardFs
einit/drone_controller/EinitHw-kss/EinitHw.c: /opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/sysroot-aarch64-kos/bin/VfsNet
einit/drone_controller/EinitHw-kss/EinitHw.c: /opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/sysroot-aarch64-kos/bin/dhcpcd_entity
einit/drone_controller/EinitHw-kss/EinitHw.c: /opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/sysroot-aarch64-kos/bin/bcm2711_mbox_arm2vc_hw
einit/drone_controller/EinitHw-kss/EinitHw.c: /opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/sysroot-aarch64-kos/bin/sdcard_hw
einit/drone_controller/EinitHw-kss/EinitHw.c: /opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/sysroot-aarch64-kos/bin/Entropy
einit/drone_controller/EinitHw-kss/EinitHw.c: /opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/sysroot-aarch64-kos/bin/dnet_brcmfmac
einit/drone_controller/EinitHw-kss/EinitHw.c: /opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/sysroot-aarch64-kos/bin/dnet_hw
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/mnt/kos/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating EinitHw-kss/EinitHw.c"
	cd /mnt/kos/build/einit/drone_controller && /opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/toolchain/bin/einit -I /mnt/kos/build/_headers_ -I /mnt/kos/build/_headers_/DroneController/.. -I /mnt/kos/build/../install/include -I /opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/sysroot-aarch64-kos/include -I /opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/toolchain/aarch64-kos/include -I /usr/local/include -I /usr/include -I //include -I /opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/toolchain/include -I /usr/X11R6/include -I /usr/pkg/include -I /opt/include -o /mnt/kos/build/einit/drone_controller/EinitHw-kss/EinitHw.c /mnt/kos/build/einit/drone_controller/EinitHw-kss/init.yaml

einit/drone_controller/CMakeFiles/EinitHw.dir/EinitHw-kss/EinitHw.c.o: einit/drone_controller/CMakeFiles/EinitHw.dir/flags.make
einit/drone_controller/CMakeFiles/EinitHw.dir/EinitHw-kss/EinitHw.c.o: einit/drone_controller/EinitHw-kss/EinitHw.c
einit/drone_controller/CMakeFiles/EinitHw.dir/EinitHw-kss/EinitHw.c.o: einit/drone_controller/CMakeFiles/EinitHw.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/mnt/kos/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object einit/drone_controller/CMakeFiles/EinitHw.dir/EinitHw-kss/EinitHw.c.o"
	cd /mnt/kos/build/einit/drone_controller && /opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/toolchain/bin/aarch64-kos-clang --target=aarch64-kos $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT einit/drone_controller/CMakeFiles/EinitHw.dir/EinitHw-kss/EinitHw.c.o -MF CMakeFiles/EinitHw.dir/EinitHw-kss/EinitHw.c.o.d -o CMakeFiles/EinitHw.dir/EinitHw-kss/EinitHw.c.o -c /mnt/kos/build/einit/drone_controller/EinitHw-kss/EinitHw.c

einit/drone_controller/CMakeFiles/EinitHw.dir/EinitHw-kss/EinitHw.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/EinitHw.dir/EinitHw-kss/EinitHw.c.i"
	cd /mnt/kos/build/einit/drone_controller && /opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/toolchain/bin/aarch64-kos-clang --target=aarch64-kos $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /mnt/kos/build/einit/drone_controller/EinitHw-kss/EinitHw.c > CMakeFiles/EinitHw.dir/EinitHw-kss/EinitHw.c.i

einit/drone_controller/CMakeFiles/EinitHw.dir/EinitHw-kss/EinitHw.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/EinitHw.dir/EinitHw-kss/EinitHw.c.s"
	cd /mnt/kos/build/einit/drone_controller && /opt/KasperskyOS-Community-Edition-RaspberryPi4b-wifi/toolchain/bin/aarch64-kos-clang --target=aarch64-kos $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /mnt/kos/build/einit/drone_controller/EinitHw-kss/EinitHw.c -o CMakeFiles/EinitHw.dir/EinitHw-kss/EinitHw.c.s

# Object files for target EinitHw
EinitHw_OBJECTS = \
"CMakeFiles/EinitHw.dir/EinitHw-kss/EinitHw.c.o"

# External object files for target EinitHw
EinitHw_EXTERNAL_OBJECTS =

einit/drone_controller/EinitHw: einit/drone_controller/CMakeFiles/EinitHw.dir/EinitHw-kss/EinitHw.c.o
einit/drone_controller/EinitHw: einit/drone_controller/CMakeFiles/EinitHw.dir/build.make
einit/drone_controller/EinitHw: einit/drone_controller/CMakeFiles/EinitHw.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/mnt/kos/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking C executable EinitHw"
	cd /mnt/kos/build/einit/drone_controller && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/EinitHw.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
einit/drone_controller/CMakeFiles/EinitHw.dir/build: einit/drone_controller/EinitHw
.PHONY : einit/drone_controller/CMakeFiles/EinitHw.dir/build

einit/drone_controller/CMakeFiles/EinitHw.dir/clean:
	cd /mnt/kos/build/einit/drone_controller && $(CMAKE_COMMAND) -P CMakeFiles/EinitHw.dir/cmake_clean.cmake
.PHONY : einit/drone_controller/CMakeFiles/EinitHw.dir/clean

einit/drone_controller/CMakeFiles/EinitHw.dir/depend: einit/drone_controller/EinitHw-kss/EinitHw.c
	cd /mnt/kos/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /mnt/kos /mnt/kos/einit/drone_controller /mnt/kos/build /mnt/kos/build/einit/drone_controller /mnt/kos/build/einit/drone_controller/CMakeFiles/EinitHw.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : einit/drone_controller/CMakeFiles/EinitHw.dir/depend

