#!/bin/sh
sudo apt-get install libx32gcc-4.8-dev

sudo apt-get install libc6-dev-i386

rm -rf prebuilt

cmake -DLINUX32=1 .

make

# mkdir -p prebuilt/32/
# cp lib/libBox2D.a prebuilt/32/
# rm -rf lib

# cmake -DLINUX64=1 .

# make


# mkdir -p prebuilt/64/
# cp lib/libBox2D.a prebuilt/64/
