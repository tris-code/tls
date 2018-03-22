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

extension InputByteStream {
    // NOTE:
    // maybe we should add something like:
    // <UnsafeStreamReader>.setMaxInputBytes(count: )
    convenience
    init<T: UnsafeStreamReader>(from stream: T, byteCount: Int) throws {
        let buffer = try stream.read(count: byteCount)
        self.init([UInt8](buffer))
    }
}

extension UnsafeStreamReader {
    @inline(__always)
    public func read<T: BinaryInteger>(_ type: T.Type) throws -> T {
        var result: T = 0
        try withUnsafeMutableBytes(of: &result) { bytes in
            let buffer = try read(count: MemoryLayout<T>.size)
            guard buffer.count == MemoryLayout<T>.size else {
                throw StreamError.insufficientData
            }
            bytes.copyMemory(from: buffer)
        }
        return result
    }
}
