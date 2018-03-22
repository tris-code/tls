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
    let expectedGroups: [Extension.SupportedGroups.Group] = [
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

    func testExtensionSupportedGroups() {
        let bytes: [UInt8] = [0x00, 0x1a, 0x00, 0x17,
                              0x00, 0x19, 0x00, 0x1c, 0x00, 0x1b, 0x00, 0x18,
                              0x00, 0x1a, 0x00, 0x16, 0x00, 0x0e, 0x00, 0x0d,
                              0x00, 0x0b, 0x00, 0x0c, 0x00, 0x09, 0x00, 0x0a]

        do {
            let stream = InputByteStream(bytes)
            let result = try Extension.SupportedGroups(from: stream)
            assertEqual(result, Extension.SupportedGroups(values: expectedGroups))
        } catch {
            fail(String(describing: error))
        }
    }

    func testExtensionSupportedGroupsType() {
        let bytes: [UInt8] = [0x00, 0x0a, 0x00, 0x1c, 0x00, 0x1a, 0x00, 0x17,
                              0x00, 0x19, 0x00, 0x1c, 0x00, 0x1b, 0x00, 0x18,
                              0x00, 0x1a, 0x00, 0x16, 0x00, 0x0e, 0x00, 0x0d,
                              0x00, 0x0b, 0x00, 0x0c, 0x00, 0x09, 0x00, 0x0a]

        do {
            let stream = InputByteStream(bytes)
            let result = try Extension(from: stream)
            assertEqual(result, .supportedGroups(Extension.SupportedGroups(values: expectedGroups)))
        } catch {
            fail(String(describing: error))
        }
    }
}
