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

extension Certificate {
    public enum StatusType: UInt8 {
        case ocsp = 0x01
    }
}

extension Certificate.StatusType {
    init<T: StreamReader>(from stream: T) throws {
        let rawStatus = try stream.read(UInt8.self)
        guard let type = Certificate.StatusType(rawValue: rawStatus) else {
            throw TLSError.invalidExtension
        }
        self = type
    }

    func encode<T: StreamWriter>(to stream: T) throws {
        try stream.write(rawValue)
    }
}
