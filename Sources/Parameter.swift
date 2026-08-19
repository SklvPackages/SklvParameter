//
//  Copyright (c) 2026 Andrew Sokolov
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation

/// A marker protocol indicating that a type can be natively stored in `UserDefaults`.
public protocol UserDefaultsPrimitive: Sendable {}

extension Int: UserDefaultsPrimitive {}
extension Bool: UserDefaultsPrimitive {}
extension Float: UserDefaultsPrimitive {}
extension Double: UserDefaultsPrimitive {}
extension String: UserDefaultsPrimitive {}
extension Date: UserDefaultsPrimitive {}

/// A property wrapper that automatically persists its value to `UserDefaults`.
@MainActor
@propertyWrapper
public final class Parameter<Value: UserDefaultsPrimitive & Equatable> {
    private let key: String
    private var value: Value

    /// Initializes the property wrapper with a default value and a storage key.
    /// - Parameters:
    ///   - defaultValue: The value to use if no existing value is found in `UserDefaults`.
    ///   - key: The string key used to store and retrieve the value from `UserDefaults`.
    public init(wrappedValue defaultValue: Value, _ key: String) {
        self.key = key

        if let storedValue = UserDefaults.standard.object(forKey: key) as? Value {
            self.value = storedValue
        } else {
            self.value = defaultValue
        }
    }

    /// The underlying value synchronized with `UserDefaults`.
    public var wrappedValue: Value {
        get {
            value
        }
        set {
            guard newValue != value else { return }
            value = newValue
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
