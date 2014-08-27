#!/bin/sh


# DEVELOPER=`xcode-select --print-path`
# ios_sdk_root="${DEVELOPER}/Platforms/iPhoneOS.platform/Developer"
# export CMAKE_IOS_SDK_ROOT=${ios_sdk_root}

# use ios-cmake to generate ios project
rm -rf build.ios
mkdir build.ios
cd build.ios

#build for ios arm64
cmake -DCMAKE_TOOLCHAIN_FILE=../toolchain/iOS.cmake  -DCMAKE_IOS_DEVELOPER_ROOT=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/ -DIOS_PLATFORM=OS -GXcode ..

# return to the uplevel folder
cd  .. 
xcodebuild -project build.ios/Project.xcodeproj -alltargets -sdk iphonesimulator7.1 -configuration Release
# xcodebuild -project build.ios/Project.xcodeproj -alltargets -sdk iphoneos7.1 -configuration Release
# create the fat package
# lipo build/Release-iphoneos/libBox2D.a build/Release-iphonesimulator/libBox2D.a -create -output libBox2D.a




# xcodebuild -project Project.xcodeproj -alltargets  -arch x86_64 -configuration Release


