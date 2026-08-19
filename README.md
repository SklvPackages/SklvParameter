# SklvParameter

[![Swift 6.3](https://img.shields.io/badge/Swift-6.3-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/Platforms-iOS_15.0+-blue.svg)](https://developer.apple.com/ios/)
[![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)](LICENSE)

A extremely lightweight, type-safe, and `@MainActor`-isolated property wrapper for `UserDefaults` built specifically for Swift 6.3. `SklvParameter` is designed strictly around KISS, DRY, and YAGNI principles, providing maximum performance, zero boilerplate, and a minimal compiled binary size. 

## Features

- 🚀 **Concurrency Ready:** Fully compliant with Swift 6 Strict Concurrency. Utilizes `@MainActor` and the `Sendable` protocol to guarantee thread-safe state management.
- 🛠 **Zero Boilerplate:** Replaces manual `UserDefaults` getters and setters with a clean, unified `@Parameter` property wrapper.
- 🗂 **Strict Type Safety:** The `UserDefaultsPrimitive` marker protocol ensures only natively supported `UserDefaults` types can be saved, preventing silent runtime failures.
- ⚡️ **High Performance:** Operates purely on memory and native Apple APIs without the overhead of heavy abstractions or generic encoders.

## Requirements

- **iOS** 15.0+
- **Xcode** 26.0+
- **Swift** 6.3+

## Installation

### Swift Package Manager

1. Inside Xcode, navigate to **File > Add Package Dependencies...**
2. Enter the repository URL: `https://github.com/SklvPackages/SklvParameter.git`
3. Define the dependency rules to **Up to Next Major** starting with `1.0.0`.

## Usage

### 1. Basic Usage
Declare your properties using the `@Parameter` property wrapper inside a `@MainActor` isolated class or struct. Pass the default value and the string key. 

```swift
import SklvParameter

@MainActor
final class Settings {
    // Automatically reads from and writes to UserDefaults.standard
    @Parameter("user_theme_preference") var isDarkModeEnabled: Bool = false
    @Parameter("user_launch_count") var launchCount: Int = 0
}

let settings = Settings()

// Getting the value
print(settings.isDarkModeEnabled) // Prints false (or the previously saved value)

// Setting a new value automatically saves it to UserDefaults
settings.isDarkModeEnabled = true
settings.launchCount += 1
```

### 2. Supported Types
`SklvParameter` restricts usage to native types to ensure safety. The following types conform to `UserDefaultsPrimitive` out of the box:

- `Int`
- `Bool`
- `Float`
- `Double`
- `String`
- `Date`

```swift
@MainActor
final class ProfileManager {
    @Parameter("profile_username") var username: String = "Guest"
    @Parameter("profile_last_login") var lastLogin: Date = Date()
    @Parameter("profile_completion_percentage") var completion: Float = 0.0
}
```

## License

`SklvParameter` is released under the MIT license. See [LICENSE](LICENSE) for details.
