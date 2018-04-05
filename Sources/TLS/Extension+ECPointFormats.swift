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
    public struct ECPointFormats: Equatable {
        public enum ECPoint: UInt8 {
            case uncompressed = 0x00
            case ansiX962_compressed_prime = 0x01
            case ansiX962_compressed_char2 = 0x02
        }

        public let values: [ECPoint]

        public init(values: [ECPoint]) {
            self.values = values
        }
    }
}

extension Extension.ECPointFormats {
    init<T: StreamReader>(from stream: T) throws {
        let length = Int(try stream.read(UInt8.self))

        var points = [ECPoint]()
        var remain = length
        while remain > 0 {
            let rawPoint = try stream.read(UInt8.self)
            guard let ecPoint = ECPoint(rawValue: rawPoint) else {
                throw TLSError.invalidExtension
            }
            points.append(ecPoint)
            remain -= MemoryLayout<UInt8>.size
        }
        self.values = points
    }
}
