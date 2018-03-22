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

class ExtensionStatusRequestTests: TestCase {
    func testExtensionStatusRequest() {
        do {
            let stream = InputByteStream([0x01, 0x00, 0x00, 0x00, 0x00])
            let result = try Extension.StatusRequest(from: stream)
            assertEqual(result, Extension.StatusRequest(certificateStatus: .ocsp))
        } catch {
            fail(String(describing: error))
        }
    }

    func testExtensionStatusRequestType() {
        do {
            let stream = InputByteStream([0x00, 0x05, 0x00, 0x05, 0x01, 0x00, 0x00, 0x00, 0x00])
            let result = try Extension(from: stream)
            assertEqual(result, .statusRequest(Extension.StatusRequest(certificateStatus: .ocsp)))
        } catch {
            fail(String(describing: error))
        }
    }
}
