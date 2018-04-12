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

class NewSessionTicketTests: TestCase {
    @nonobjc
    let bytes: [UInt8] = [
        // handshake
        0x16,
        // version
        0x03, 0x03,
        // length: 202
        0x00, 0xca,
        // new session ticket
        0x04,
        // length: 198
        0x00, 0x00, 0xc6,
        // lifetime hint: 100800
        0x00, 0x01, 0x89, 0xc0,
        // length: 192
        0x00, 0xc0,
        // ticket
        0x00,
        0xd8, 0x67, 0x6e, 0x0f, 0x91, 0xfd, 0x21, 0x2f,
        0x3c, 0x7a, 0xfd, 0x23, 0x20, 0x48, 0xa1, 0x78,
        0x03, 0xa1, 0xb3, 0x8e, 0xf1, 0x55, 0x92, 0xbe,
        0xfc, 0x81, 0x35, 0x21, 0x55, 0x83, 0xe5, 0x58,
        0xc3, 0xaa, 0x34, 0x9d, 0xd5, 0xdc, 0x9b, 0xd6,
        0xdf, 0x05, 0xf3, 0x8a, 0x0b, 0xcf, 0xce, 0x70,
        0x98, 0xe8, 0x93, 0xc8, 0x77, 0xeb, 0xb0, 0x9f,
        0xbb, 0x30, 0x73, 0x83, 0x2b, 0x2c, 0xf3, 0x45,
        0x78, 0x81, 0x5e, 0x8f, 0x8b, 0x57, 0x9f, 0xe7,
        0xe4, 0x4f, 0xb7, 0xdd, 0x45, 0xa1, 0xd8, 0x1a,
        0xfd, 0xf0, 0x4b, 0xe6, 0x84, 0xf1, 0x6d, 0x65,
        0xed, 0xc5, 0xfc, 0x69, 0x5c, 0x94, 0xb4, 0x85,
        0xe1, 0xca, 0x98, 0x54, 0x47, 0x19, 0xe0, 0x40,
        0x90, 0xa0, 0xf9, 0x05, 0x2f, 0x83, 0x88, 0x17,
        0x0f, 0x43, 0xae, 0x23, 0x47, 0xfe, 0x48, 0xae,
        0x4c, 0x57, 0x4e, 0x9d, 0x84, 0xfa, 0xa7, 0x5a,
        0xd4, 0xcf, 0x76, 0x61, 0x54, 0x54, 0x7a, 0x0e,
        0x74, 0xb6, 0xd6, 0xf7, 0x49, 0x28, 0x72, 0x77,
        0xbb, 0x34, 0xab, 0x2a, 0x7b, 0x83, 0x1e, 0x24,
        0x1d, 0x4b, 0x41, 0x45, 0xea, 0x8c, 0x0e, 0x5d,
        0xa6, 0x50, 0x01, 0x0a, 0x48, 0xa7, 0xc4, 0xb7,
        0xae, 0x17, 0x65, 0x4b, 0x1e, 0xf5, 0x7a, 0x9c,
        0x3e, 0xab, 0xe8, 0xe1, 0xfc, 0xf4, 0xef, 0x52,
        0xa7, 0x81, 0x43, 0xd2, 0x30, 0xba, 0x3c
    ]

    var newSessionTicket: NewSessionTicket {
        return .init(
            lifetime: 100800,
            data: [UInt8](bytes[15...]))
    }

    func testDecode() {
        scope {
            let stream = InputByteStream(bytes)
            let record = try RecordLayer(from: stream)
            assertEqual(record.version, .tls12)
            assertEqual(record.content, .handshake(
                .newSessionTicket(newSessionTicket)))
        }
    }

    func testEncode() {
        scope {
            let stream = OutputByteStream()
            let record = RecordLayer(
                version: .tls12,
                content: .handshake(.newSessionTicket(newSessionTicket)))
            try record.encode(to: stream)
            assertEqual(stream.bytes, bytes)
        }
    }
}
