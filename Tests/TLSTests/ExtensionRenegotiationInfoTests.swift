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

class ExtensionRenegotiationInfoTests: TestCase {
    typealias RenegotiationInfo = Extension.RenegotiationInfo

    func testExtensionRenegotiationInfo() {
        do {
            let stream = InputByteStream([0x00])
            let result = try Extension.RenegotiationInfo(from: stream)
            assertEqual(result, RenegotiationInfo(values: []))
        } catch {
            fail(String(describing: error))
        }
    }

    func testExtensionRenegotiationInfoType() {
        do {
            let stream = InputByteStream([0xff, 0x01, 0x00, 0x01, 0x00])
            let result = try Extension(from: stream)
            assertEqual(result, .renegotiationInfo(RenegotiationInfo(values: [])))
        } catch {
            fail(String(describing: error))
        }
    }
}
