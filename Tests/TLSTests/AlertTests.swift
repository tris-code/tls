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

class AlertTests: TestCase {
    func testDecode() {
        scope {
            let stream = InputByteStream([0x01, 0x00])
            let alert = try Alert(from: stream)
            assertEqual(alert.level, .warning)
            assertEqual(alert.description, .closeNotify)
        }
    }

    func testEncode() {
        scope {
            let stream = OutputByteStream()
            let expected: [UInt8] = [0x01, 0x00]
            let alert = Alert(level: .warning, description: .closeNotify)
            try alert.encode(to: stream)
            assertEqual(stream.bytes, expected)
        }
    }
}
