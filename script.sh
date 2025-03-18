#!/bin/bash

# Update and upgrade the system
apt update
apt upgrade -y

# Install necessary packages
apt install -y \
    nano bc bison ca-certificates curl flex gcc git libc6-dev \
    libssl-dev openssl python-is-python3 ssh wget zip zstd make \
    clang gcc-arm-linux-gnueabi software-properties-common build-essential \
    libarchive-tools gcc-aarch64-linux-gnu pigz python3 python2

# Clone necessary repositories
apt install build-essential
git clone --depth=1 https://github.com/Kavindu-Deshapriya/android_kernel_RMX3063Q.git
cd android_kernel_RMX3063Q
git clone --depth=1 https://github.com/techyminati/android_prebuilts_clang_host_linux-x86_clang-5484270 clang
git clone --depth=1 https://github.com/EternalX-project/aarch64-linux-gnu.git gcc64
git clone --depth=1 https://github.com/EternalX-project/arm-linux-gnueabi.git gcc32

# Run setup scripts
curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash -s -- --cleanup
curl -LSs "https://raw.githubusercontent.com/rifsxd/KernelSU-Next/next/kernel/setup.sh" | bash -s next

# Set environment variables
export PATH="${PWD}/clang/bin:$PATH"
export CC="${PWD}/clang/bin/clang"
export KBUILD_BUILD_USER="Snowluna"
export KBUILD_BUILD_HOST="nefertari"

# Build the project
make -j$(nproc --all) O=out ARCH=arm64 oppo6765_defconfig
make -j$(nproc --all) ARCH=arm64 O=out CC="clang" CROSS_COMPILE="${PWD}/gcc64/bin/aarch64-linux-gnu-" CROSS_COMPILE_ARM32="${PWD}/gcc32/bin/arm-linux-gnueabi-"
