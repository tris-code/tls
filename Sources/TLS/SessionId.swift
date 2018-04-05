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

public struct SessionId: Equatable {
    public let data: [UInt8]

    public init(data: [UInt8]) {
        self.data = data
    }
}

extension SessionId {
    init<T: StreamReader>(from stream: T) throws {
        let length = Int(try stream.read(UInt8.self))

        guard length > 0 else {
            self.data = []
            return
        }

        self.data = try stream.read(count: length)
    }

    func encode<T: StreamWriter>(to stream: T) throws {
        try stream.write(UInt8(data.count))
        try stream.write(data)
    }
}
