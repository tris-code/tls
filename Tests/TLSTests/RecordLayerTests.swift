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

class RecordLayerTests: TestCase {
    func testDecode() {
        scope {
            let stream = InputByteStream([0x18, 0x03, 0x01, 0x00, 0x00])
            let recordLayer = try RecordLayer(from: stream)
            assertEqual(
                recordLayer,
                .init(version: .tls10, content: .heartbeat))
        }
    }

    func testEncode() {
        scope {
            let stream = OutputByteStream()
            let expected: [UInt8] = [0x18, 0x03, 0x01, 0x00, 0x00]
            let recordLayer = RecordLayer(version: .tls10, content: .heartbeat)
            try recordLayer.encode(to: stream)
            assertEqual(stream.bytes, expected)
        }
    }
}
