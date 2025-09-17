#!/bin/bash

# Definir a toolchain específica para macOS
RUST_TOOLCHAIN="1.88.0-x86_64-apple-darwin"

# Instalar a toolchain se não existir
rustup toolchain install $RUST_TOOLCHAIN

export IPHONEOS_DEPLOYMENT_TARGET=12.0
echo "Building for iOS"
rustup run $RUST_TOOLCHAIN rustc --version
rustup run $RUST_TOOLCHAIN cargo --version
rustup target add aarch64-apple-ios --toolchain $RUST_TOOLCHAIN
rustup run $RUST_TOOLCHAIN cargo build --target aarch64-apple-ios --release
xcodebuild \
    -create-xcframework \
    -library target/aarch64-apple-ios/release/libisar.a \
    -output isar.xcframework 
zip -r isar_ios.xcframework.zip isar.xcframework
