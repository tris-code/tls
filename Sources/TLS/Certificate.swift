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

public struct Certificate: Equatable {
    public let bytes: [UInt8]
}

extension Array where Element == Certificate {
    init<T: StreamReader>(from stream: T) throws {
        let length = Int(try stream.read(UInt24.self).byteSwapped)
        self = try stream.withLimitedStream(by: length) { stream in
            var certificates = [Certificate]()
            while !stream.isEmpty {
                certificates.append(try Certificate(from: stream))
            }
            return certificates
        }
    }

    func encode<T: StreamWriter>(to stream: T) throws {
        guard count > 0 else {
            return
        }
        try stream.countingLength(as: UInt24.self) { stream in
            for value in self {
                try value.encode(to: stream)
            }
        }
    }
}

extension Certificate {
    init<T: StreamReader>(from stream: T) throws {
        let length = Int(try stream.read(UInt24.self).byteSwapped)
        self.bytes = try stream.read(count: length)
    }

    func encode<T: StreamWriter>(to stream: T) throws {
        try stream.countingLength(as: UInt24.self) { stream in
            try stream.write(bytes)
        }
    }
}
