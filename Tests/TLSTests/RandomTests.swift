/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

import Test
import Stream
@testable import TLS

class RandomTests: TestCase {
    func testRandom() {
        let random = Random()
        assertTrue(random.time > 0)
        assertNotEqual(Random().bytes, Random().bytes)
    }

    func testRandomBytes() {
        let random = Random()
        var allowedRepeatingBytesCount = 1
        for i in 0..<random.bytes.count - 1 {
            guard random.bytes[i] != random.bytes[i + 1] else {
                if allowedRepeatingBytesCount > 0 {
                    allowedRepeatingBytesCount -= 1
                    continue
                }
                fail("it's very likely that random is broken")
                return
            }
        }
    }
}
