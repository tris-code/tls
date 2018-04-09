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
import Platform

// https://tools.ietf.org/html/rfc4366#section-3.6

extension Extension {
    public enum StatusRequest: Equatable {
        case none
        case ocsp(OCSPStatusRequest)
    }

    public struct OCSPStatusRequest: Equatable {
        public let responderIdList: [UInt8]
        public let extensions: [UInt8]

        public init (responderIdList: [UInt8] = [], extensions: [UInt8] = []) {
            self.responderIdList = responderIdList
            self.extensions = extensions
        }
    }
}

extension Extension.OCSPStatusRequest {
    init(from stream: StreamReader) throws {
        let respondersLength = Int(try stream.read(UInt16.self))
        switch respondersLength {
        case 0: self.responderIdList = []
        default: self.responderIdList = try stream.read(count: respondersLength)
        }

        let extensionsLength = Int(try stream.read(UInt16.self))
        switch extensionsLength {
        case 0: self.extensions = []
        default: self.extensions = try stream.read(count: extensionsLength)
        }
    }

    func encode(to stream: StreamWriter) throws {
        try stream.write(UInt16(responderIdList.count))
        if responderIdList.count > 0 {
            try stream.write(responderIdList)
        }
        try stream.write(UInt16(extensions.count))
        if extensions.count > 0 {
            try stream.write(extensions)
        }
    }
}

extension Extension.StatusRequest {
    init(from stream: StreamReader) throws {
        let type = try Certificate.Status.RawType(from: stream)
        switch type {
        case .ocsp: self = .ocsp(try Extension.OCSPStatusRequest(from: stream))
        }
    }

    func encode(to stream: StreamWriter) throws {
        switch self {
        case .none:
            return
        case .ocsp(let request):
            try Certificate.Status.RawType.ocsp.encode(to: stream)
            try request.encode(to: stream)
        }
    }
}
