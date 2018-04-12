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

class ServerHelloDone: TestCase {
    @nonobjc
    let bytes: [UInt8] = [0x16, 0x03, 0x03, 0x00, 0x04, 0x0e, 0x00, 0x00, 0x00]

    func testDecode() {
        scope {
            let stream = InputByteStream(bytes)
            let record = try RecordLayer(from: stream)
            assertEqual(record.version, .tls12)
            assertEqual(record.content, .handshake(.serverHelloDone))
        }
    }

    func testEncode() {
        scope {
            let stream = OutputByteStream()
            let record = RecordLayer(
                version: .tls12,
                content: .handshake(.serverHelloDone))
            try record.encode(to: stream)
            assertEqual(stream.bytes, bytes)
        }
    }
}
