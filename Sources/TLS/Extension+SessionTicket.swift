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
    public struct SessionTicket: Equatable {
        public let data: [UInt8]

        public init(data: [UInt8]) {
            self.data = data
        }
    }
}

extension Extension.SessionTicket {
    init(from stream: StreamReader) throws {
        self.data = try stream.readUntilEnd()
    }

    func encode(to stream: StreamWriter) throws {
        try stream.write(data)
    }
}
