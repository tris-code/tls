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
    public enum ECPointFormat: UInt8 {
        case uncompressed = 0x00
        case ansiX962_compressed_prime = 0x01
        case ansiX962_compressed_char2 = 0x02
    }
}

extension Array where Element == Extension.ECPointFormat {
    init(from stream: StreamReader) throws {
        let length = Int(try stream.read(UInt8.self))

        var points = [Element]()
        var remain = length
        while remain > 0 {
            let rawPoint = try stream.read(UInt8.self)
            guard let ecPoint = Element(rawValue: rawPoint) else {
                throw TLSError.invalidExtension
            }
            points.append(ecPoint)
            remain -= MemoryLayout<UInt8>.size
        }
        self = points
    }

    func encode(to stream: StreamWriter) throws {
        guard count > 0 else {
            return
        }
        try stream.write(UInt8(count))
        for value in self {
            try stream.write(value.rawValue)
        }
    }
}
