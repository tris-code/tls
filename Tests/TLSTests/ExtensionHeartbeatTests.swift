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

class ExtensionHeartbeatTests: TestCase {
    func testDecode() {
        scope {
            let stream = InputByteStream([0x01])
            let result = try Extension.Heartbeat(from: stream)
            assertEqual(result, .init(mode: .allowed))
        }
    }

    func testDecodeExtension() {
        scope {
            let stream = InputByteStream([0x00, 0x0f, 0x00, 0x01, 0x01])
            let result = try Extension(from: stream)
            assertEqual(result, .heartbeat(.init(mode: .allowed)))
        }
    }

    func testEncode() {
        scope {
            let stream = OutputByteStream()
            let expected: [UInt8] = [0x01]
            let heartbeat = Extension.Heartbeat(mode: .allowed)
            try heartbeat.encode(to: stream)
            assertEqual(stream.bytes, expected)
        }
    }

    func testEncodeExtension() {
        scope {
            let stream = OutputByteStream()
            let expected: [UInt8] = [0x00, 0x0f, 0x00, 0x01, 0x01]
            let heartbeat = Extension.heartbeat(.init(mode: .allowed))
            try heartbeat.encode(to: stream)
            assertEqual(stream.bytes, expected)
        }
    }
}
