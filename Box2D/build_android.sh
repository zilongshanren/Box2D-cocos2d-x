#!/bin/sh

export ANDROID_NDK_TOOLCHAIN_ROOT=/Users/guanghui/AndroidDev/android-ndk-r9d/toolchains/arm-linux-androideabi-4.8/prebuilt/darwin-x86_64/bin/
export ANDROID_NDK=/Users/guanghui/AndroidDev/android-ndk-r9d/
rm -rf build.android/ 
mkdir build.android
cd build.android

cmake -DCMAKE_TOOLCHAIN_FILE=../android.toolchain.cmake ..
