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
    struct Heartbeat: Equatable {
        enum Mode: UInt8 {
            case allowed = 1
        }
        let mode: Mode
    }
}

extension Extension.Heartbeat {
    init<T: UnsafeStreamReader>(from stream: T) throws {
        let rawMode = try stream.read(UInt8.self)
        guard let mode = Mode(rawValue: rawMode) else {
            throw TLSError.invalidExtension
        }
        self.mode = mode
    }
}
