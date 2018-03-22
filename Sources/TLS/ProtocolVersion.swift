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

enum ProtocolVersion: UInt16 {
    case tls10 = 0x0301
    case tls11 = 0x0302
    case tls12 = 0x0303
}

extension ProtocolVersion {
    var major: UInt8 {
        return UInt8(truncatingIfNeeded: (self.rawValue >> 8))
    }
    var minor: UInt8 {
        return UInt8(truncatingIfNeeded: self.rawValue)
    }
}

extension ProtocolVersion {
    init<T: UnsafeStreamReader>(from stream: T) throws {
        let rawVersion = try stream.read(UInt16.self).byteSwapped
        guard let version = ProtocolVersion(rawValue: rawVersion) else {
            throw TLSError.invalidProtocolVerion
        }
        self = version
    }
}
