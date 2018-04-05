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
    public struct ServerName: Equatable {
        public struct Name: Equatable {
            public enum NameType: UInt8 {
                case hostName = 0
            }
            public let type: NameType
            public let value: String

            public init(type: NameType, value: String) {
                self.type = type
                self.value = value
            }
        }

        public let values: [Name]

        public init(values: [Name]) {
            self.values = values
        }
    }
}

extension Extension.ServerName.Name {
    init<T: StreamReader>(from stream: T) throws {
        let rawType = try stream.read(UInt8.self)
        guard let type = NameType(rawValue: rawType) else {
            throw TLSError.invalidExtension
        }
        self.type = type

        let length = Int(try stream.read(UInt16.self).byteSwapped)
        self.value = try stream.read(count: length) { bytes in
            return String(decoding: bytes, as: UTF8.self)
        }
    }
}

extension Extension.ServerName {
    init<T: StreamReader>(from stream: T) throws {
        let uint = try stream.read(UInt16.self).byteSwapped
        let length = Int(uint)
        // TODO: avoid copying, plaease read NOTE in this extension
        let stream = try InputByteStream(from: stream, byteCount: length)

        var names = [Name]()
        while !stream.isEmpty {
            names.append(try Name(from: stream))
        }
        self.values = names
    }
}
