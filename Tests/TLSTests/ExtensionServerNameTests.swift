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

class ExtensionServerNameTests: TestCase {
    func testDecodeName() {
        scope {
            let stream = InputByteStream(
                [0x00, 0x00, 0x05, 0x79, 0x61, 0x2e, 0x72, 0x75])
            let result = try Extension.ServerName.Name(from: stream)
            assertEqual(result.type, .hostName)
            assertEqual(result.value, "ya.ru")
        }
    }

    func testDecode() {
        scope {
            let stream = InputByteStream(
                [0x00, 0x08, 0x00, 0x00, 0x05, 0x79, 0x61, 0x2e, 0x72, 0x75])
            let result = try Extension.ServerName(from: stream)
            assertEqual(result, .init(values: [
                .init(type: .hostName, value: "ya.ru")]))
        }
    }

    func testDecodeExtension() {
        scope {
            let stream = InputByteStream(
                [0x00, 0x00, 0x00, 0x0a, 0x00, 0x08, 0x00, 0x00,
                 0x05, 0x79, 0x61, 0x2e, 0x72, 0x75])
            let result = try Extension(from: stream)
            assertEqual(result, .serverName(.init(values: [
                .init(type: .hostName, value: "ya.ru")])))
        }
    }

    func testEncodeName() {
        scope {
            let stream = OutputByteStream()
            let expected: [UInt8] =
                [0x00, 0x00, 0x05, 0x79, 0x61, 0x2e, 0x72, 0x75]
            let name = Extension.ServerName.Name(
                type: .hostName, value: "ya.ru")
            try name.encode(to: stream)
            assertEqual(stream.bytes, expected)
        }
    }

    func testEncode() {
        scope {
            let stream = OutputByteStream()
            let expected: [UInt8] =
                [0x00, 0x08, 0x00, 0x00, 0x05, 0x79, 0x61, 0x2e, 0x72, 0x75]
            let serverName = Extension.ServerName(values: [
                .init(type: .hostName, value: "ya.ru")])
            try serverName.encode(to: stream)
            assertEqual(stream.bytes, expected)
        }
    }

    func testEncodeExtension() {
        scope {
            let stream = OutputByteStream()
            let expected: [UInt8] =
                [0x00, 0x00, 0x00, 0x0a, 0x00, 0x08, 0x00, 0x00,
                 0x05, 0x79, 0x61, 0x2e, 0x72, 0x75]
            let serverNameExtension = Extension.serverName(
                .init(values: [.init(type: .hostName, value: "ya.ru")]))
            try serverNameExtension.encode(to: stream)
            assertEqual(stream.bytes, expected)
        }
    }
}
