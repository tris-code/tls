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
    func testExtensionServerNameName() {
        do {
            let stream = InputByteStream([0x00, 0x00, 0x05, 0x79, 0x61, 0x2e, 0x72, 0x75])
            let result = try Extension.ServerName.Name(from: stream)
            assertEqual(result.type, .hostName)
            assertEqual(result.value, "ya.ru")
        } catch {
            fail(String(describing: error))
        }
    }

    func testExtensionServerName() {
        do {
            let stream = InputByteStream([0x00, 0x08, 0x00, 0x00, 0x05, 0x79, 0x61, 0x2e, 0x72, 0x75])
            let result = try Extension.ServerName(from: stream)
            assertEqual(result, Extension.ServerName(values: [
                Extension.ServerName.Name(type: .hostName, value: "ya.ru")]))
        } catch {
            fail(String(describing: error))
        }
    }

    func testExtensionServerNameType() {
        do {
            let stream = InputByteStream([0x00, 0x00, 0x00, 0x0a, 0x00, 0x08, 0x00, 0x00, 0x05, 0x79, 0x61, 0x2e, 0x72, 0x75])
            let result = try Extension(from: stream)
            assertEqual(result, .serverName(Extension.ServerName(values: [
                Extension.ServerName.Name(type: .hostName, value: "ya.ru")])))
        } catch {
            fail(String(describing: error))
        }
    }
}
