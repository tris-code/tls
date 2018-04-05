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

public struct RecordLayer: Equatable {
    public let version: Version
    public let content: Content

    public init(version: Version, content: Content) {
        self.version = version
        self.content = content
    }
}

extension RecordLayer {
    fileprivate enum ContentType: UInt8 {
        case changeChiperSpec = 20
        case alert = 21
        case handshake = 22
        case applicationData = 23
        case heartbeat = 24
    }

    public enum Content: Equatable {
        case changeChiperSpec(ChangeCiperSpec)
        case alert(Alert)
        case handshake(Handshake)
        case applicationData([UInt8])
        case heartbeat
    }
}

extension RecordLayer {
    public init<T: StreamReader>(from stream: T) throws {
        let type = try ContentType(from: stream)

        self.version = try Version(from: stream)

        let length = Int(try stream.read(UInt16.self).byteSwapped)
        self.content = try stream.withLimitedStream(by: length) { stream in
            switch type {
            case .changeChiperSpec:
                return .changeChiperSpec(try ChangeCiperSpec(from: stream))
            case .alert:
                return .alert(try Alert(from: stream))
            case .handshake:
                return .handshake(try Handshake(from: stream))
            case .applicationData:
                return .applicationData(try stream.read(count: length))
            case .heartbeat:
                return .heartbeat
            }
        }
    }

    public func encode<T: StreamWriter>(to stream: T) throws {
        func write(_ type: ContentType) throws {
            try stream.write(type.rawValue)
        }
        switch content {
        case .changeChiperSpec: try write(.changeChiperSpec)
        case .alert: try write(.alert)
        case .handshake: try write(.handshake)
        case .applicationData: try write(.applicationData)
        case .heartbeat: try write(.heartbeat)
        }

        try version.encode(to: stream)

        try stream.countingLength(as: UInt16.self) { stream in
            switch content {
            case .changeChiperSpec(let value): try value.encode(to: stream)
            case .alert(let value): try value.encode(to: stream)
            case .handshake(let value): try value.encode(to: stream)
            case .applicationData(let value): try stream.write(value)
            case .heartbeat: break
            }
        }
    }
}

extension RecordLayer.ContentType {
    init<T: StreamReader>(from stream: T) throws {
        let rawType = try stream.read(UInt8.self)
        guard let type = RecordLayer.ContentType(rawValue: rawType) else {
            throw TLSError.invalidRecordContentType
        }
        self = type
    }

    func encode<T: StreamWriter>(to stream: T) throws {
        try stream.write(self.rawValue)
    }
}
