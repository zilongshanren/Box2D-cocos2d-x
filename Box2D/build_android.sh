#!/bin/sh


# export ANDROID_NDK=$HOME/AndroidDev/android-ndk-r9d/
source ~/.bashrc 
ANDROID_API_LEVEL=19

# generate the android toolchain of arm
sh $ANDROID_NDK/build/tools/make-standalone-toolchain.sh --platform=android-$ANDROID_API_LEVEL --install-dir=./android-toolchain --system=darwin-x86_64 --ndk-dir=/Users/guanghui/AndroidDev/android-ndk-r9d/ --toolchain=arm-linux-androideabi-4.8

# generate thte android toolchain of x86
sh $ANDROID_NDK/build/tools/make-standalone-toolchain.sh --platform=android-$ANDROID_API_LEVEL --install-dir=./android-toolchain-x86 --system=darwin-x86_64 --ndk-dir=/Users/guanghui/AndroidDev/android-ndk-r9d/ --toolchain=x86-4.8

export PATH=$PATH:./android-toolchain/bin
export ANDROID_STANDALONE_TOOLCHAIN=./android-toolchain


rm -rf build.android/ 
mkdir build.android
cd build.android

cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=../toolchain/android.toolchain.cmake -DANDROID_ABI="armeabi" -DANDROID=1 ..

make 

cd ..
rm -rf build.android/ 
mkdir build.android/ 
cd build.android/ 

#build for armeabi-v7a
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=../toolchain/android.toolchain.cmake -DANDROID=1 ..
make

cd ..
rm -rf build.android/ 
mkdir build.android/ 
cd build.android/ 

#build for x86
export PATH=$PATH:./android-toolchain-x86/bin
export PATH=$PATH:$ANDROID_NDK/build/tools/
export ANDROID_STANDALONE_TOOLCHAIN=./android-toolchain-x86
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=../toolchain/android.toolchain.cmake -DANDROID_ABI="x86" -DANDROID=1 ..

make


cd ..
# ndk-depends libs/x86/libChipmunk.a 
rm -rf build.android/ 

mv libs/* prebuilt/android/
rm -rf libs
