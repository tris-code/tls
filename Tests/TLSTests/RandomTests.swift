/******************************************************************************
 *                                                                            *
 * Tris Foundation disclaims copyright to this source code.                   *
 * In place of a legal notice, here is a blessing:                            *
 *                                                                            *
 *     May you do good and not evil.                                          *
 *     May you find forgiveness for yourself and forgive others.              *
 *     May you share freely, never taking more than you give.                 *
 *                                                                            *
 ******************************************************************************/

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
