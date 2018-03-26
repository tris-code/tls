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

struct RecordLayer: Equatable {
    let version: ProtocolVersion
    let content: Content
}

extension RecordLayer {
    fileprivate init(_ version: ProtocolVersion, _ content: Content) {
        self.version = version
        self.content = content
    }

    fileprivate enum ContentType: UInt8 {
        case changeChiperSpec = 20
        case alert = 21
        case handshake = 22
        case applicationData = 23
        case heartbeat = 24
    }

    enum Content: Equatable {
        case changeChiperSpec(ChangeCiperSpec)
        case alert(Alert)
        case handshake(Handshake)
        case applicationData([UInt8])
        case heartbeat
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
}

extension RecordLayer {
    init<T: StreamReader>(from stream: T) throws {
        let type = try ContentType(from: stream)

        self.version = try ProtocolVersion(from: stream)

        let length = Int(try stream.read(UInt16.self).byteSwapped)

        switch type {
        case .changeChiperSpec:
            self.content = .changeChiperSpec(try ChangeCiperSpec(from: stream))

        case .alert:
            self.content = .alert(try Alert(from: stream))

        case .handshake:
            self.content = .handshake(try Handshake(from: stream))

        case .applicationData:
            self.content = .applicationData(try stream.read(count: length))

        case .heartbeat:
            self.content = .heartbeat
        }
    }
}
