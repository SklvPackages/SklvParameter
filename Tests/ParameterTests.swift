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

import Testing
import Foundation
import SklvParameter

/// A test suite verifying the behavior of the Parameter property wrapper.
@Suite("Parameter Tests")
@MainActor
struct ParameterTests {

    /// Tests that the wrapper uses the default value when no data exists in UserDefaults.
    @Test("Loads default value when UserDefaults is empty")
    func testDefaultValue() {
        let key = UUID().uuidString
        let parameter = Parameter(wrappedValue: 42, key)

        #expect(parameter.wrappedValue == 42)
    }

    /// Tests that String values are correctly saved to and read from UserDefaults.
    @Test("Stores and retrieves String values")
    func testStringPersistence() {
        let key = UUID().uuidString
        defer { UserDefaults.standard.removeObject(forKey: key) }

        let parameter = Parameter(wrappedValue: "Initial", key)
        parameter.wrappedValue = "Updated"

        #expect(parameter.wrappedValue == "Updated")
        #expect(UserDefaults.standard.string(forKey: key) == "Updated")
    }

    /// Tests that Bool values are correctly saved to and read from UserDefaults.
    @Test("Stores and retrieves Bool values")
    func testBoolPersistence() {
        let key = UUID().uuidString
        defer { UserDefaults.standard.removeObject(forKey: key) }

        let parameter = Parameter(wrappedValue: false, key)
        parameter.wrappedValue = true

        #expect(parameter.wrappedValue == true)
        #expect(UserDefaults.standard.bool(forKey: key) == true)
    }

    /// Tests that the wrapper prioritizes an existing UserDefaults value over the default value during initialization.
    @Test("Loads existing value from UserDefaults upon initialization")
    func testLoadingExistingValue() {
        let key = UUID().uuidString
        defer { UserDefaults.standard.removeObject(forKey: key) }

        let date = Date()
        UserDefaults.standard.set(date, forKey: key)

        let parameter = Parameter(wrappedValue: Date(timeIntervalSince1970: 0), key)

        #expect(parameter.wrappedValue == date)
    }

    /// Tests that the @Parameter property wrapper syntax functions correctly when applied to a class property.
    @Test("Property wrapper syntax works correctly")
    func testPropertyWrapperSyntax() {
        let key = "Test_Count_Key"
        defer { UserDefaults.standard.removeObject(forKey: key) }

        @MainActor
        final class Settings {
            @Parameter("Test_Count_Key") var count: Int = 0
        }

        let settings = Settings()
        settings.count = 100

        #expect(settings.count == 100)
        #expect(UserDefaults.standard.integer(forKey: key) == 100)
    }
}
