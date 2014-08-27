xcodebuild -project Box2D.xcodeproj -alltargets -sdk iphonesimulator7.1 -configuration Release
xcodebuild -project Box2D.xcodeproj -alltargets -sdk iphoneos7.1 -configuration Release
lipo build/Release-iphoneos/libBox2D.a build/Release-iphonesimulator/libBox2D.a -create -output libBox2D.a

xcodebuild -project Project.xcodeproj -alltargets  -arch x86_64 -configuration Release


