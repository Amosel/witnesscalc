Run on iOS:

`rm -rf build_witnesscalc_ios && rm -rf package_ios`
`make ios`
`xcodebuild -target install -configuration Release -project build_witnesscalc_ios/witnesscalc.xcodeproj`

add `package_ios` (as reference it is better) to your xcode project.
add -lc++ to other compiler flags to the xcode project target.
