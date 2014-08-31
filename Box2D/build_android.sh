#!/bin/sh

export PATH=$PATH:$HOME/Github/android-toolchain/bin
# export ANDROID_NDK_TOOLCHAIN_ROOT=$HOME/Github/android-toolchain
export ANDROID_STANDALONE_TOOLCHAIN=$HOME/Github/android-toolchain
# export ANDROID_NDK=$HOME/AndroidDev/android-ndk-r9d/


rm -rf build.android/ 
mkdir build.android
cd build.android

cmake -DCMAKE_TOOLCHAIN_FILE=../android.toolchain.cmake -DANDROID_ABI="armeabi" -DANDROID=1 ..

make 

cd ..
rm -rf build.android/ 
mkdir build.android/ 
cd build.android/ 

#build for armeabi-v7a
cmake -DCMAKE_TOOLCHAIN_FILE=../android.toolchain.cmake -DANDROID=1 ..
make

cd ..
rm -rf build.android/ 
mkdir build.android/ 
cd build.android/ 

#build for x86
export PATH=$PATH:$HOME/Github/android-toolchain-x86/bin
export ANDROID_STANDALONE_TOOLCHAIN=$HOME/Github/android-toolchain-x86
cmake -DCMAKE_TOOLCHAIN_FILE=../android.toolchain.cmake -DANDROID_ABI="x86" -DANDROID=1 ..

make


cd ..
rm -rf build.android/ 
