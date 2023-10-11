#  Some useful command line tools"
## run simulator
xcrun simctl boot "iPhone 15"
## make simulator visible
open -a Simulator
## get list of device types
xcrun simctl list devicetypes
## create new simulator
xcrun simctl create iPhone-7-Plus com.apple.CoreSimulator.SimDeviceType.iPhone-7-Plus com.apple.CoreSimulator.SimRuntime.iOS-13-4
## clone 
xcrun simctl clone booted NewPhone
## install app
xcrun simctl install booted ~/MyApplication.app
## launch app by bundle
xcrun simctl launch booted ru.cian.mobile
## terminate app by bundle
xcrun simctl launch terminate ru.cian.mobile
## uninstall app
xcrun simctl uninstall booted ru.cian.mobile
## send push notification
firstly create json with  .apns name extension
{
    "aps": {
        "alert": {
            "title": "Tester on Steroids",
            "body": "About mobile apps testing"
        },
        "badge": 3,
        "sound": "default"
    }
}
secondly
xcrun simctl push booted ru.cian.mobile ~/Documents/mocks/push.apns
## run XCUITests in parallel by classes
xcodebuild \
 -scheme SimpleCalculatorUITests \
 -destination 'platform=iOS Simulator,name=iPhone X,OS=11.0' \
 -only-testing:SimpleCalculatorUITests/MinusTest \
 -only-testing:SimpleCalculatorUITests/ResetTest \
 test & \
xcodebuild \
 -scheme SimpleCalculatorUITests \
 -destination 'platform=iOS Simulator,name=iPhone X 2,OS=11.0' \
 -only-testing:SimpleCalculatorUITests/AdditionTest \
 test & \
xcodebuild \
 -scheme SimpleCalculatorUITests \
 -destination 'platform=iOS Simulator,name=iPhone X 3,OS=11.0' \
 -only-testing:SimpleCalculatorUITests/MultiplyTest \
 test &
 ## run XCUTTest in parallel by schemes
 xcodebuild \
 -scheme SimpleCalculatorUITests \
 -destination 'platform=iOS Simulator,name=iPhone X,OS=11.0' \
 test & \
xcodebuild \
 -scheme "SimpleCalculatorUITests copy" \
 -destination 'platform=iOS Simulator,name=iPhone X 2,OS=11.0' \
 test & \
xcodebuild \
 -scheme "SimpleCalculatorUITests copy 2" \
 -destination 'platform=iOS Simulator,name=iPhone X 3,OS=11.0' \
 test &
 ## run XCUTTest in parallel on different devices
 xcodebuild \
 -scheme SimpleCalculatorUITests \
 -destination 'platform=iOS Simulator,name=iPhone X,OS=11.0' \
 -destination 'platform=iOS Simulator,name=iPhone 8,OS=11.0' \
 test
## get real USB attached iPhone devices UUID
device_type='iPhone'
devicesString=$(system_profiler SPUSBDataType |
 grep -A 11 -w "${device_type}" |
 grep "Serial Number" |
 awk '{ print $3 }')
devices=(${devicesString// / })
for (( i=0; i<${#devices[@]}; i++ ));
do
  devices[$i]="id=${devices[$i]}"
done
## parallel testing on real devices
xcodebuild \
 -scheme SimpleCalculatorUITests \
 -destination 'id=${UDID_1}' \
 test & \
xcodebuild \
 -scheme "SimpleCalculatorUITests copy" \
 -destination 'id=${UDID_2}' \
 test &
