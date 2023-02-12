#!/bin/zsh

set -eo pipefail

xcodebuild \
    -project Pokemon\ Tabletop\ Adventure.xcodeproj \
    -scheme PTA\ Companion \
    -sdk iphonesimulator \
    -destination 'platform=iOS Simulator,name=iPhone 14,OS=16.2' \
    clean test \
    | xcbeautify
