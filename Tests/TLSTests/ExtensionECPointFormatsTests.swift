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

class ExtensionECPointFormatsTests: TestCase {
    func testExtensionECPointFormats() {
        scope {
            let stream = InputByteStream([0x03, 0x00, 0x01, 0x02])
            let result = try Extension.ECPointFormats(from: stream)
            assertEqual(result, .init(values: [
                .uncompressed,
                .ansiX962_compressed_prime,
                .ansiX962_compressed_char2]))
        }
    }

    func testExtensionECPointFormatsType() {
        scope {
            let stream = InputByteStream(
                [0x00, 0x0b, 0x00, 0x04, 0x03, 0x00, 0x01, 0x02])
            let result = try Extension(from: stream)
            assertEqual(result, .ecPointFormats(.init(values: [
                .uncompressed,
                .ansiX962_compressed_prime,
                .ansiX962_compressed_char2])))
        }
    }
}
