#!/bin/zsh
# Buduje Ukryj.app (bez Xcode project, samo swiftc)
set -e
cd "$(dirname "$0")"
APP=build/Ukryj.app
rm -rf build && mkdir -p $APP/Contents/MacOS
swiftc -O main.swift -o $APP/Contents/MacOS/Ukryj
cat > $APP/Contents/Info.plist <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>CFBundleName</key><string>Ukryj</string>
<key>CFBundleIdentifier</key><string>pl.local.ukryj</string>
<key>CFBundleExecutable</key><string>Ukryj</string>
<key>CFBundlePackageType</key><string>APPL</string>
<key>LSUIElement</key><true/>
</dict></plist>
PLIST
codesign --force --sign - $APP
echo "OK: $APP"
