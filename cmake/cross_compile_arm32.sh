#!/bin/bash
# NOTE: arm32 debian 11 bullseye requires gcc/g++ 10
# sudo apt install gcc-10-arm-linux-gnueabihf g++-10-arm-linux-gnueabihf

# Default: no static flags
static_flag_c=""
static_flag_cxx=""

# Parse arguments
while getopts "s" opt; do
  case $opt in
    s)
      static_flag_c="-static-libgcc"
      static_flag_cxx="-static-libstdc++"
      echo "Static linking enabled for C and C++."
      ;;
    j)
        jobs="$OPTARG"
      ;;
    *)
      ;;
  esac
done

cmake -S . -B build_arm32 \
    -DCMAKE_TOOLCHAIN_FILE=linux_arm32_crosscompile_toolchain.cmake \
    -Donnxruntime_BUILD_SHARED_LIB=ON \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -Donnxruntime_ENABLE_CPUINFO=OFF \
    -DCMAKE_C_FLAGS="-Wno-error=type-limits $static_flag_c" \
    -DCMAKE_CXX_FLAGS="-Wno-error=type-limits $static_flag_cxx" \
    -Donnxruntime_DISABLE_RTTI=OFF

make -j${jobs:-2} -C build_arm32
