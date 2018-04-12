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

public struct NewSessionTicket: Equatable {
    public let lifetime: Int
    public let data: [UInt8]

    public init(lifetime: Int, data: [UInt8]) {
        self.lifetime = lifetime
        self.data = data
    }
}

extension NewSessionTicket {
    init(from stream: StreamReader) throws {
        self.lifetime = Int(try stream.read(UInt32.self))
        let length = Int(try stream.read(UInt16.self))
        self.data = try stream.read(count: length)
    }

    func encode(to stream: StreamWriter) throws {
        try stream.write(UInt32(lifetime))
        try stream.write(UInt16(data.count))
        try stream.write(data)
    }
}
