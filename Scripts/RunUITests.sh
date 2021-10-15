xcodebuild \
	-project JourneySpendings.xcodeproj \
	-scheme MobileAppUITests \
	-sdk iphonesimulator \
	-destination 'platform=iOS Simulator,name=iPhone 8,OS=15.0' \
	test

