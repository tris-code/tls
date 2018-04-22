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

class ExtensionRenegotiationInfoTests: TestCase {
    func testDecode() {
        scope {
            let stream = InputByteStream([0x00])
            let result = try Extension.RenegotiationInfo(from: stream)
            assertEqual(result, .init(renegotiatedConnection: []))
        }
    }

    func testDecodeExtension() {
        scope {
            let stream = InputByteStream([0xff, 0x01, 0x00, 0x01, 0x00])
            let result = try Extension(from: stream)
            assertEqual(result, .renegotiationInfo(.init()))
        }
    }

    func testEncode() {
        scope {
            let stream = OutputByteStream()
            let expected: [UInt8] = [0x00]
            let info = Extension.RenegotiationInfo(renegotiatedConnection: [])
            try info.encode(to: stream)
            assertEqual(stream.bytes, expected)
        }
    }

    func testEncodeExtension() {
        scope {
            let stream = OutputByteStream()
            let expected: [UInt8] = [0xff, 0x01, 0x00, 0x01, 0x00]
            let info = Extension.renegotiationInfo(.init())
            try info.encode(to: stream)
            assertEqual(stream.bytes, expected)
        }
    }
}
