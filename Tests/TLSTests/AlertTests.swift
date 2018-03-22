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

class AlertTests: TestCase {
    func testAlert() {
        do {
            let stream = InputByteStream([0x01, 0x00])
            let alert = try Alert(from: stream)
            assertEqual(alert.level, .warning)
            assertEqual(alert.description, .closeNotify)
        } catch {
            fail(String(describing: error))
        }
    }
}
