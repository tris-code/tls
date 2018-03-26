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
import Platform

struct Random: Equatable {
    let time: Int
    let bytes: [UInt8]

    fileprivate static let bytesSize = 28
}

extension Random {
    init() {
        self.time = Platform.time(nil)
        var bytes = [UInt8](repeating: 0, count: Random.bytesSize)
        arc4random_buf(&bytes, bytes.count)
        self.bytes = bytes
    }
}

extension Random {
    init<T: StreamReader>(from stream: T) throws {
        self.time = Int(try stream.read(UInt32.self).byteSwapped)
        self.bytes = try stream.read(count: 28)
    }
}
