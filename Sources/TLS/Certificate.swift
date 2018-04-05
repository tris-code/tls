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

}

extension StreamReader {
    func read(_ type: UInt24.Type) throws -> UInt24 {
        var value = UInt24(0)
        try withUnsafeMutableBytes(of: &value) { buffer in
            try read(count: MemoryLayout<UInt24>.size) { bytes in
                buffer.copyMemory(from: bytes)
            }
        }
        return value
    }
}

extension InputByteStream {
    var isEmpty: Bool {
        return position == bytes.count
    }
}

extension Array where Element == Certificate {
    init<T: StreamReader>(from stream: T) throws {
        let length = Int(try stream.read(UInt24.self).byteSwapped)
        // TODO: avoid copying, plaease read NOTE in this extension
        let stream = try InputByteStream(from: stream, byteCount: length)

        var certificates = [Certificate]()
        while !stream.isEmpty {
            certificates.append(try Certificate(from: stream))
        }
        self = certificates
    }
}

extension Certificate {
    fileprivate static let headerSize = 3
    init<T: StreamReader>(from stream: T) throws {
        fatalError("not implemented")
        // let length = Int(buffer[0]) << 16 | Int(buffer[1]) << 8 | Int(buffer[2])
    }
}
