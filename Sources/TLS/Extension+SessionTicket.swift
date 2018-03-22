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
    struct SessionTicket: Equatable {
        let data: [UInt8]
    }
}

extension Extension.SessionTicket {
    init<T: UnsafeStreamReader>(from stream: T) throws {
        let buffer = try stream.readAllBytes()
        self.data = [UInt8](buffer)
    }
}

extension UnsafeStreamReader {
    func readAllBytes() throws -> UnsafeRawBufferPointer {
        return try read(while: { _ in true }, allowingExhaustion: true)
    }
}
