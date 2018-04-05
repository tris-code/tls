/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

import Stream

extension Extension {
    public struct SignatureAlgorithms: Equatable {
        public let values: [Algorithm]

        public struct Algorithm: Equatable {
            public enum HashType: UInt8 {
                case none   = 0x00
                case md5    = 0x01
                case sha1   = 0x02
                case sha224 = 0x03
                case sha256 = 0x04
                case sha384 = 0x05
                case sha512 = 0x06
            }

            public enum SignatureType: UInt8 {
                case anonymous = 0x00
                case rsa       = 0x01
                case dsa       = 0x02
                case ecdsa     = 0x03
            }

            public let hash: HashType
            public let signature: SignatureType
        }
    }
}

extension Extension.SignatureAlgorithms {
    init<T: StreamReader>(from stream: T) throws {
        let length = Int(try stream.read(UInt16.self).byteSwapped)

        var algorithms = [Algorithm]()
        var remain = length
        while remain > 0 {
            let rawHash = try stream.read(UInt8.self)
            let rawSignature = try stream.read(UInt8.self)
            guard let hash = Algorithm.HashType(rawValue: rawHash),
                let signature = Algorithm.SignatureType(rawValue: rawSignature) else {
                    throw TLSError.invalidExtension
            }
            algorithms.append(Algorithm(hash: hash, signature: signature))
            remain -= MemoryLayout<UInt8>.size + MemoryLayout<UInt8>.size
        }
        self.values = algorithms
    }
}
