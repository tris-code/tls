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

enum CompressionMethod: UInt8 {
    case none = 0
}

extension Array where Element == CompressionMethod {
    init<T: UnsafeStreamReader>(from stream: T) throws {
        let length = Int(try stream.read(UInt8.self))

        var methods: [CompressionMethod] = []
        var remain = length
        while remain > 0 {
            methods.append(try CompressionMethod(from: stream))
            remain -= 1
        }

        self = methods
    }
}

extension CompressionMethod {
    init<T: UnsafeStreamReader>(from stream: T) throws {
        let rawMethod = try stream.read(UInt8.self)
        guard let method = CompressionMethod(rawValue: rawMethod) else {
            throw TLSError.invalidCompressionMethod
        }
        self = method
    }
}
