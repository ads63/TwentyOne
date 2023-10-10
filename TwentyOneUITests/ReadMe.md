#  Some usefil command line tools"
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
