#!/bin/sh
# in order to build 32 bit application on 64bit machine
# we have to install the following packages
# and also we should specify the CXX_FLAGS = m32
sudo apt-get install libx32gcc-4.8-dev

sudo apt-get install libc6-dev-i386

sudo apt-get install lib32stdc++6

sudo apt-get install g++-multilib

LIBNAME="box2d"

rm -rf prebuilt/linux

mkdir build.linux
cd build.linux
cmake -DCMAKE_BUILD_TYPE=Release -DLINUX32=1 ..

make

cd ..
mkdir -p prebuilt/linux/32/
cp build.linux/lib/lib"${LIBNAME}".a prebuilt/linux/32/
rm -rf build.linux

mkdir build.linux
cd build.linux
cmake -DCMAKE_BUILD_TYPE=Release -DLINUX64=1 ..

make

cd ..
mkdir -p prebuilt/linux/64/
cp build.linux/lib/lib"${LIBNAME}".a prebuilt/linux/64/
rm -rf build.linux
