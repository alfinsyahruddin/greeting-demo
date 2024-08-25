#!/bin/bash

# Build the dylib
cargo build

# Generate bindings
cargo run --bin uniffi-bindgen generate --library ./target/debug/libgreeting.dylib --language swift --out-dir ./bindings

# Add the iOS targets and build
for TARGET in \
    aarch64-apple-darwin \
    aarch64-apple-ios \
    aarch64-apple-ios-sim \
    x86_64-apple-darwin \
    x86_64-apple-ios; do
    rustup target add $TARGET
    cargo build --release --target=$TARGET
done

# Rename *.modulemap to module.modulemap
mv ./bindings/greetingFFI.modulemap ./bindings/module.modulemap

# Move the Swift file to the project
rm ./ios/Greeting.swift
mv ./bindings/greeting.swift ./ios/Greeting.swift

# Recreate XCFramework
rm -rf "ios/Greeting.xcframework"
xcodebuild -create-xcframework \
    -library ./target/aarch64-apple-ios-sim/release/libgreeting.a -headers ./bindings \
    -library ./target/aarch64-apple-ios/release/libgreeting.a -headers ./bindings \
    -output "ios/Greeting.xcframework"

# Cleanup
rm -rf bindings
