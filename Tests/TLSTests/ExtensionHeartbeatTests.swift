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

class ExtensionHeartbeatTests: TestCase {
    func testExtensionHeartbeat() {
        do {
            let stream = InputByteStream([0x01])
            let result = try Extension.Heartbeat(from: stream)
            assertEqual(result, Extension.Heartbeat(mode: .allowed))
        } catch {
            fail(String(describing: error))
        }
    }

    func testExtensionHeartbeatType() {
        do {
            let stream = InputByteStream([0x00, 0x0f, 0x00, 0x01, 0x01])
            let result = try Extension(from: stream)
            assertEqual(result, .heartbeat(Extension.Heartbeat(mode: .allowed)))
        } catch {
            fail(String(describing: error))
        }
    }
}
