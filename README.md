##About This Repository
- This is NOT the official Box2D standalone project. Official website
  is [here](http://box2d.org/downloads/)
- the version of Box2D is 2.3.0

## Prerequisite

You must setup ANDROID_NDK environment variable in your ~/.bashrc file to point to your NDK directory.

##Build
At first:

```cpp
cd Box2D
```

###Build for Android
```cpp
./build_android.sh
```

###Build for iOS and Mac
Change the following line to match your own iOS SDK version

```cpp
IOS_SDK_VERSION="7.1"
```

```cpp
./build_iosmac.sh
```


##Build for Linux
```cpp
./build_linux.sh
```

##Build for Windows, WP8 and WinRT
1. Generate VS project file from CMakeLists.txt

2. Compile the static library.
