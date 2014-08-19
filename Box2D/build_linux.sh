#!/bin/sh
# in order to build 32 bit application on 64bit machine
# we have to install the following packages
# and also we should specify the CXX_FLAGS = m32
sudo apt-get install libx32gcc-4.8-dev

sudo apt-get install libc6-dev-i386

sudo apt-get install lib32stdc++6

sudo apt-get install g++-multilib

rm -rf prebuilt

cmake -DLINUX32=1 .

make

mkdir -p prebuilt/32/
cp lib/libBox2D.a prebuilt/32/
rm -rf lib

cmake -DLINUX32=0 .

make


mkdir -p prebuilt/64/
cp lib/libBox2D.a prebuilt/64/
