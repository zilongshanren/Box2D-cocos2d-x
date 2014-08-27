PROJ=box2d
ifeq ($(IOS), 1)
    ARCH=armv7
    DEVICE=OS
    CC_FLAGS=-arch $(ARCH)
    CFLAGS_FLAGS=-mcpu=cortex-a8 -marm
else
    ARCH=i386
    CC_FLAGS=-arch $(ARCH)
    DEVICE=Simulator
endif

DEVROOT=//Applications/Xcode.app/Contents/Developer/Platforms/iPhone$(DEVICE).platform/Developer
SDKROOT=${DEVROOT}/SDKs/iPhone$(DEVICE)7.1.sdk
CC=$(DEVROOT)/usr/bin/clang $(CC_FLAGS)
LD=$(CC)

IDIR = $(shell pwd)../../../../
CFLAGS=-isysroot ${SDKROOT} $(CFLAGS_FLAGS)  -I$(IDIR)
LDFLAGS=-isysroot ${SDKROOT} -Wl, -syslibroot ${SDKROOT}

SRC=$(wildcard  Collision/*.cpp Collision/Shapes/*.cpp Common/*.cpp Dynamics/*.cpp Rope/*.cpp Dynamics/Contacts/*.cpp Dynamics/Joints/*.cpp)
OBJS=$(patsubst %.cpp,%.o,$(SRC))
# DEPS=ssl crypto expat

LIBDIR=$(shell pwd)/libs
LDLIBS=$(patsubst %, $(DIR)/lib%.a)

all:$(ARCH)-$(PROJ).a

$(ARCH)-$(PROJ).a: $(OBJS)
	@echo $(LDLIBS) $(OBJS)
	ar rcs $@ $(OBJS)
	ranlib $@

.PHONY: lipo
lipo:
	lipo -create -arch armv7 armv7-$(PROJ).a -arch i386 i386-$(PROJ).a -output $(PROJ).a

clean:
	rm $(OBJS)


.PHONY: realclean
realclean: clean
	rm *.a
