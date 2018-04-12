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

class ChangeCipherSpecTests: TestCase {
    @nonobjc
    let bytes: [UInt8] = [0x14, 0x03, 0x03, 0x00, 0x01, 0x01]

    func testDecode() {
        scope {
            let stream = InputByteStream(bytes)
            let record = try RecordLayer(from: stream)
            assertEqual(record.version, .tls12)
            assertEqual(record.content, .changeChiperSpec(.default))
        }
    }

    func testEncode() {
        scope {
            let stream = OutputByteStream()
            let record = RecordLayer(version: .tls12, content: .changeChiperSpec(.default))
            try record.encode(to: stream)
            assertEqual(stream.bytes, bytes)
        }
    }
}
