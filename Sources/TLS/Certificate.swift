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

extension UnsafeStreamReader {
    func read(_ type: UInt24.Type) throws -> UInt24 {
        var value = UInt24(0)
        try withUnsafeMutableBytes(of: &value) { bytes in
            let buffer = try read(count: MemoryLayout<UInt24>.size)
            guard buffer.count == MemoryLayout<UInt24>.size else {
                throw StreamError.insufficientData
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
    init<T: UnsafeStreamReader>(from stream: T) throws {
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


struct Certificate: Equatable {
    fileprivate static let headerSize = 3
    init<T: UnsafeStreamReader>(from stream: T) throws {
        fatalError("not implemented")
    }
}
