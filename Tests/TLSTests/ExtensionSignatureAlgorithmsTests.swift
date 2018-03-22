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

class ExtensionSignatureAlgorithmsTests: TestCase {
    let expectedSignatures: [Extension.SignatureAlgorithms.Algorithm] = [
        Extension.SignatureAlgorithms.Algorithm(hash: .sha512, signature: .rsa),
        Extension.SignatureAlgorithms.Algorithm(hash: .sha512, signature: .dsa),
        Extension.SignatureAlgorithms.Algorithm(hash: .sha512, signature: .ecdsa),
        Extension.SignatureAlgorithms.Algorithm(hash: .sha384, signature: .rsa),
        Extension.SignatureAlgorithms.Algorithm(hash: .sha384, signature: .dsa),
        Extension.SignatureAlgorithms.Algorithm(hash: .sha384, signature: .ecdsa),
        Extension.SignatureAlgorithms.Algorithm(hash: .sha256, signature: .rsa),
        Extension.SignatureAlgorithms.Algorithm(hash: .sha256, signature: .dsa),
        Extension.SignatureAlgorithms.Algorithm(hash: .sha256, signature: .ecdsa),
        Extension.SignatureAlgorithms.Algorithm(hash: .sha224, signature: .rsa),
        Extension.SignatureAlgorithms.Algorithm(hash: .sha224, signature: .dsa),
        Extension.SignatureAlgorithms.Algorithm(hash: .sha224, signature: .ecdsa),
        Extension.SignatureAlgorithms.Algorithm(hash: .sha1, signature: .rsa),
        Extension.SignatureAlgorithms.Algorithm(hash: .sha1, signature: .dsa),
        Extension.SignatureAlgorithms.Algorithm(hash: .sha1, signature: .ecdsa),
    ]

    func testExtensionSignatureAlgorithms() {
        let bytes: [UInt8] = [0x00, 0x1e, 0x06, 0x01, 0x06, 0x02, 0x06, 0x03,
                              0x05, 0x01, 0x05, 0x02, 0x05, 0x03, 0x04, 0x01,
                              0x04, 0x02, 0x04, 0x03, 0x03, 0x01, 0x03, 0x02,
                              0x03, 0x03, 0x02, 0x01, 0x02, 0x02, 0x02, 0x03]

        do {
            let stream = InputByteStream(bytes)
            let result = try Extension.SignatureAlgorithms(from: stream)
            assertEqual(result, Extension.SignatureAlgorithms(values: expectedSignatures))
        } catch {
            fail(String(describing: error))
        }
    }

    func testExtensionSignatureAlgorithmsType() {
        let bytes: [UInt8] = [0x00, 0x0d, 0x00, 0x20,
                              0x00, 0x1e, 0x06, 0x01, 0x06, 0x02, 0x06, 0x03,
                              0x05, 0x01, 0x05, 0x02, 0x05, 0x03, 0x04, 0x01,
                              0x04, 0x02, 0x04, 0x03, 0x03, 0x01, 0x03, 0x02,
                              0x03, 0x03, 0x02, 0x01, 0x02, 0x02, 0x02, 0x03]

        do {
            let stream = InputByteStream(bytes)
            let result = try Extension(from: stream)
            assertEqual(result, .signatureAlgorithms(Extension.SignatureAlgorithms(values: expectedSignatures)))
        } catch {
            fail(String(describing: error))
        }
    }
}
