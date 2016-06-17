# Eddystone Beacon scanning for iOS

This app scans for nearby Eddystone beacons using Google's Nearby Messages library for iOS.

Before building/running, follow these steps:
- If the CocoaPods tool is not installed, follow the instructions at
[CocoaPods Getting Started guide](https://guides.cocoapods.org/using/getting-started.html).
- Run `pod install` and open the xcworkspace file.
- In AppDelegate.m, insert your Google developer project iOS API key at the top.
- In the build settings, set the bundle ID used in your Google developer project.
