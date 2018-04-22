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

class ExtensionStatusRequestTests: TestCase {
    typealias StatusRequest = Extension.StatusRequest

    func testDecode() {
        scope {
            let stream = InputByteStream([0x01, 0x00, 0x00, 0x00, 0x00])
            let result = try StatusRequest(from: stream)
            assertEqual(result, .ocsp(.init()))
        }
    }

    func testDecodeExtension() {
        scope {
            let stream = InputByteStream(
                [0x00, 0x05, 0x00, 0x05, 0x01, 0x00, 0x00, 0x00, 0x00])
            let result = try Extension(from: stream)
            assertEqual(result, .statusRequest(.ocsp(.init())))
        }
    }

    func testEncode() {
        scope {
            let stream = OutputByteStream()
            let expected: [UInt8] = [0x01, 0x00, 0x00, 0x00, 0x00]
            let statusRequest = StatusRequest.ocsp(.init())
            try statusRequest.encode(to: stream)
            assertEqual(stream.bytes, expected)
        }
    }

    func testEncodeExtension() {
        scope {
            let stream = OutputByteStream()
            let expected: [UInt8] =
                [0x00, 0x05, 0x00, 0x05, 0x01, 0x00, 0x00, 0x00, 0x00]
            let statusRequest = Extension.statusRequest(.ocsp(.init()))
            try statusRequest.encode(to: stream)
            assertEqual(stream.bytes, expected)
        }
    }
}
