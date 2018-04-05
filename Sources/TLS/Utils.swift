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

extension StreamReader {
    func withLimitedStream<T>(
        by byteCount: Int,
        body: (UnsafeRawInputStream) throws -> T) throws -> T
    {
        return try read(count: byteCount) { bytes in
            let stream = UnsafeRawInputStream(
                pointer: bytes.baseAddress!,
                count: bytes.count)
            return try body(stream)
        }
    }
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
