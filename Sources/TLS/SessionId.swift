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

struct SessionId: Equatable {
    let data: [UInt8]
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
}
