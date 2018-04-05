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

class ExtensionSupportedGroupsTests: TestCase {
    let groups: [Extension.SupportedGroups.Group] = [
        .secp256r1,
        .secp521r1,
        .brainpoolP512r1,
        .brainpoolP384r1,
        .secp384r1,
        .brainpoolP256r1,
        .secp256k1,
        .sect571r1,
        .sect571k1,
        .sect409k1,
        .sect409r1,
        .sect283k1,
        .sect283r1
    ]

    func testDecode() {
        scope {
            let stream = InputByteStream(
                [0x00, 0x1a, 0x00, 0x17,
                 0x00, 0x19, 0x00, 0x1c, 0x00, 0x1b, 0x00, 0x18,
                 0x00, 0x1a, 0x00, 0x16, 0x00, 0x0e, 0x00, 0x0d,
                 0x00, 0x0b, 0x00, 0x0c, 0x00, 0x09, 0x00, 0x0a])
            let result = try Extension.SupportedGroups(from: stream)
            assertEqual(result, .init(values: groups))
        }
    }

    func testDecodeExtension() {
        scope {
            let stream = InputByteStream(
                [0x00, 0x0a, 0x00, 0x1c, 0x00, 0x1a, 0x00, 0x17,
                 0x00, 0x19, 0x00, 0x1c, 0x00, 0x1b, 0x00, 0x18,
                 0x00, 0x1a, 0x00, 0x16, 0x00, 0x0e, 0x00, 0x0d,
                 0x00, 0x0b, 0x00, 0x0c, 0x00, 0x09, 0x00, 0x0a])
            let result = try Extension(from: stream)
            assertEqual(result, .supportedGroups(.init(values: groups)))
        }
    }

    func testEncode() {
        scope {
            let expected: [UInt8] =
                [0x00, 0x1a, 0x00, 0x17,
                 0x00, 0x19, 0x00, 0x1c, 0x00, 0x1b, 0x00, 0x18,
                 0x00, 0x1a, 0x00, 0x16, 0x00, 0x0e, 0x00, 0x0d,
                 0x00, 0x0b, 0x00, 0x0c, 0x00, 0x09, 0x00, 0x0a]
            let stream = OutputByteStream()
            let supportedGroups = Extension.SupportedGroups(values: groups)
            try supportedGroups.encode(to: stream)
            assertEqual(stream.bytes, expected)
        }
    }

    func testEncodeExtension() {
        scope {
            let expected: [UInt8] =
                [0x00, 0x0a, 0x00, 0x1c, 0x00, 0x1a, 0x00, 0x17,
                 0x00, 0x19, 0x00, 0x1c, 0x00, 0x1b, 0x00, 0x18,
                 0x00, 0x1a, 0x00, 0x16, 0x00, 0x0e, 0x00, 0x0d,
                 0x00, 0x0b, 0x00, 0x0c, 0x00, 0x09, 0x00, 0x0a]
            let stream = OutputByteStream()
            let supportedGroupsExtension = Extension.supportedGroups(
                .init(values: groups))
            try supportedGroupsExtension.encode(to: stream)
            assertEqual(stream.bytes, expected)
        }
    }
}
