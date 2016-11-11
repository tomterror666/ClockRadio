default: test uitest

test:
	xcodebuild -verbose -workspace ClockRadio.xcworkspace -scheme ClockRadioTests -sdk iphonesimulator10.1 ARCHS=i386 ONLY_ACTIVE_ARCH=NO -destination "platform=iOS Simulator,name=iPhone 5,OS=10.1" test

uitest:
	xcodebuild -verbose -workspace ClockRadio.xcworkspace -scheme ClockRadioKIFUITests -sdk iphonesimulator10.1 ARCHS=i386 ONLY_ACTIVE_ARCH=NO -destination "platform=iOS Simulator,name=iPhone 5,OS=10.1" test GCC_PREPROCESSOR_DEFINITIONS='$$GCC_PREPROCESSOR_DEFINITIONS UITEST_SIMULATOR=1'

cleanAll:
	xcodebuild -version
	cd ClockRadio;xcodebuild -alltargets clean;cd ..

cleanDerivedData: cleanAll
	rm -rdf ~/Library/Developer/Xcode/DerivedData/ClockRadio-*

cleanGCDA:
	find -s ~/Library/Developer/Xcode/DerivedData/ClockRadio-* -name "*.gcda" -print0 | xargs -0 rm
	
killAll_iOSSimulators:
	./killiPhoneSimulator.sh
 
