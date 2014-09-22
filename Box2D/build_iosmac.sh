#!/bin/sh

LIBNAME="box2d"
IOS_SDK_VERSION="7.1"

# use ios-cmake to generate ios project
rm -rf prebuilt/ios
rm -rf prebuilt/mac

rm -rf build.ios
mkdir build.ios
cd build.ios

#generate ios project
cmake -DCMAKE_TOOLCHAIN_FILE=../toolchain/iOS_32.cmake  -DCMAKE_IOS_DEVELOPER_ROOT=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/  -GXcode ..


# build iphone simulator
xcodebuild -project Project.xcodeproj -alltargets -sdk iphonesimulator"${IOS_SDK_VERSION}" -configuration Release

cd ..
mkdir -p lib/i386
cp build.ios/lib/Release/lib"${LIBNAME}".a lib/i386


# build iphone os, this is a fat lib
xcodebuild -project build.ios/Project.xcodeproj -alltargets -sdk iphoneos"${IOS_SDK_VERSION}" -configuration Release

mkdir -p lib/armv7
cp build.ios/lib/Release/lib"${LIBNAME}".a lib/armv7

rm -rf build.ios
mkdir build.ios
cd build.ios

#generate ios project
cmake -DCMAKE_TOOLCHAIN_FILE=../toolchain/iOS_64.cmake  -DCMAKE_IOS_DEVELOPER_ROOT=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/  -GXcode ..


# build iphone simulator 64 bit
xcodebuild -project Project.xcodeproj -alltargets -sdk iphonesimulator"${IOS_SDK_VERSION}" -configuration Release

cd ..
mkdir -p lib/x86_64
cp build.ios/lib/Release/lib"${LIBNAME}".a lib/x86_64


# build iphone os, this is a fat lib
xcodebuild -project build.ios/Project.xcodeproj -alltargets -sdk iphoneos"${IOS_SDK_VERSION}" -configuration Release  

mkdir -p lib/arm64
cp build.ios/lib/Release/lib"${LIBNAME}".a lib/arm64

# create the fat package
lipo lib/i386/lib"${LIBNAME}".a lib/x86_64/lib"${LIBNAME}".a lib/armv7/lib"${LIBNAME}".a lib/arm64/lib"${LIBNAME}".a -create -output lib"${LIBNAME}".a
lipo -info lib"${LIBNAME}".a

mkdir -p prebuilt/ios
mv lib"${LIBNAME}".a prebuilt/ios
rm -rf lib
rm -rf build.ios

echo "finished build ios fat library"

rm -rf build.mac
mkdir build.mac
cd build.mac
cmake -G Xcode ..

xcodebuild -project Project.xcodeproj -alltargets  -arch x86_64 -configuration Release

cd ..
mkdir -p prebuilt/mac
cp build.mac/lib/Release/lib"${LIBNAME}".a prebuilt/mac/lib"${LIBNAME}".a
rm -rf build.mac


