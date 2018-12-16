/******************************************************************************
 *                                                                            *
 * Tris Foundation disclaims copyright to this source code.                   *
 * In place of a legal notice, here is a blessing:                            *
 *                                                                            *
 *     May you do good and not evil.                                          *
 *     May you find forgiveness for yourself and forgive others.              *
 *     May you share freely, never taking more than you give.                 *
 *                                                                            *
 ******************************************************************************/

import Crypto
import Stream

extension Array where Element == X509.Certificate {
    init(from stream: StreamReader) throws {
        self = try stream.withSubStream(sizedBy: UInt24.self) { stream in
            var certificates = [X509.Certificate]()
            while !stream.isEmpty {
                let x509 = try stream.withSubStream(sizedBy: UInt24.self)
                { stream in
                    return try X509.Certificate(from: stream)
                }
                certificates.append(x509)
            }
            return certificates
        }
    }

    func encode(to stream: StreamWriter) throws {
        guard count > 0 else {
            return
        }
        try stream.withSubStream(sizedBy: UInt24.self) { stream in
            for value in self {
                try stream.withSubStream(sizedBy: UInt24.self) { stream in
                    try value.encode(to: stream)
                }
            }
        }
    }
}

extension X509.Certificate {
    init(from stream: StreamReader) throws {
        let asn1 = try ASN1(from: stream)
        try self.init(from: asn1)
    }

    func encode(to stream: StreamWriter) throws {
        let asn1 = self.encode()
        try asn1.encode(to: stream)
    }
}
