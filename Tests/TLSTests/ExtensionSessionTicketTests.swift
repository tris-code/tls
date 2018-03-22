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

class ExtensionSessionTicketTests: TestCase {
    func testExtensionSessionTicketEmpty() {
        do {
            let stream = InputByteStream([0x00, 0x23, 0x00, 0x00])
            let result = try Extension(from: stream)
            assertEqual(result, .sessionTicket(Extension.SessionTicket(data: [])))
        } catch {
            fail(String(describing: error))
        }
    }

    func testExtensionSessionTicketEmptyRandom() {
        do {
            let stream = InputByteStream([0x00, 0x23, 0x00, 0x05, 0xFF, 0xA3, 0x7B, 0x04, 0x33])
            let result = try Extension(from: stream)
            assertEqual(result, .sessionTicket(Extension.SessionTicket(data: [0xFF, 0xA3, 0x7B, 0x04, 0x33])))
        } catch {
            fail(String(describing: error))
        }
    }
}
