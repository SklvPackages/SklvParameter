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
@testable import SklvParameter

@Suite("Parameter Tests")
struct ParameterTests {

    @Test()
    func defaultWhenNoValueString() async throws {
        let key = UUID().uuidString

        @Parameter(key) var username: String = "Guest"
        #expect(username == "Guest")

        let stored = UserDefaults.standard.object(forKey: key)
        #expect(stored == nil)

        UserDefaults.standard.removeObject(forKey: key)
    }

    @Test()
    func persistsAfterSetString() async throws {
        let key = UUID().uuidString

        @Parameter(key) var username: String = "Guest"
        username = "Andrew"

        let stored = UserDefaults.standard.string(forKey: key)
        #expect(stored == "Andrew")
        #expect(username == "Andrew")

        UserDefaults.standard.removeObject(forKey: key)
    }

    @Test()
    func settingSameValueNoChange() async throws {
        let key = UUID().uuidString

        @Parameter(key) var flag: Bool = false
        flag = true

        let first = UserDefaults.standard.bool(forKey: key)
        #expect(first == true)

        flag = true

        let second = UserDefaults.standard.bool(forKey: key)
        #expect(second == true)

        UserDefaults.standard.removeObject(forKey: key)
    }

    @Test()
    func keysAreIsolated() async throws {
        let key1 = UUID().uuidString
        let key2 = UUID().uuidString

        @Parameter(key1) var a: String = "A"
        @Parameter(key2) var b: String = "B"

        a = "AA"
        b = "BB"

        #expect(UserDefaults.standard.string(forKey: key1) == "AA")
        #expect(UserDefaults.standard.string(forKey: key2) == "BB")

        UserDefaults.standard.removeObject(forKey: key1)
        UserDefaults.standard.removeObject(forKey: key2)
    }
}
