#!/bin/sh


# DEVELOPER=`xcode-select --print-path`
# ios_sdk_root="${DEVELOPER}/Platforms/iPhoneOS.platform/Developer"
# export CMAKE_IOS_SDK_ROOT=${ios_sdk_root}

# use ios-cmake to generate ios project
rm -rf build.ios
rm libBox2D.a
mkdir build.ios
cd build.ios

#generate ios project
cmake -DCMAKE_TOOLCHAIN_FILE=../toolchain/iOS_32.cmake  -DCMAKE_IOS_DEVELOPER_ROOT=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/  -GXcode ..


# build iphone simulator
xcodebuild -project Project.xcodeproj -alltargets -sdk iphonesimulator7.1 -configuration Release

cd ..
mkdir -p lib/i386
cp build.ios/lib/Release/libbox2d.a lib/i386


# build iphone os, this is a fat lib
xcodebuild -project build.ios/Project.xcodeproj -alltargets -sdk iphoneos7.1 -configuration Release

mkdir -p lib/armv7
cp build.ios/lib/Release/libbox2d.a lib/armv7

rm -rf build.ios
mkdir build.ios
cd build.ios

#generate ios project
cmake -DCMAKE_TOOLCHAIN_FILE=../toolchain/iOS_64.cmake  -DCMAKE_IOS_DEVELOPER_ROOT=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/  -GXcode ..


# build iphone simulator 64 bit
xcodebuild -project Project.xcodeproj -alltargets -sdk iphonesimulator7.1 -configuration Release

cd ..
mkdir -p lib/x86_64
cp build.ios/lib/Release/libbox2d.a lib/x86_64


# build iphone os, this is a fat lib
xcodebuild -project build.ios/Project.xcodeproj -alltargets -sdk iphoneos7.1 -configuration Release  

mkdir -p lib/arm64
cp build.ios/lib/Release/libbox2d.a lib/arm64

# create the fat package
lipo lib/i386/libbox2d.a lib/x86_64/libbox2d.a lib/armv7/libbox2d.a lib/arm64/libbox2d.a -create -output libBox2D.a
lipo -info libBox2D.a

mkdir -p prebuilt/ios
mv libBox2D.a prebuilt/ios
rm -rf lib
rm -rf build.ios

echo "finished build ios fat library"


# xcodebuild -project Project.xcodeproj -alltargets  -arch x86_64 -configuration Release


