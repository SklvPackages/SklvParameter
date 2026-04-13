# SklvParameter

A lightweight property wrapper that persists Equatable primitive values to UserDefaults with minimal boilerplate.

## Requirements

- iOS 15.0+
- Xcode 26.4+
- Swift 6.3+

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/SklvParameter/SklvParameter.git", .upToNextMajor(from: "1.0.0"))
]
```

## Usage

```swift
let key = "3F5A8E2B-9C14-4D7E-9B13-2B7D3F0C4A61"

@Parameter(key) var length: Int = 20
length = 10

if length <= 10 {
    // Do something
} 
```

## License

SklvParameter is released under the MIT license. See LICENSE for details.
