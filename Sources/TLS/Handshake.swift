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

enum Handshake: Equatable {
    case helloRequest
    case clientHello(ClientHello)
    case serverHello(ServerHello)
    case helloVerifyRequest
    case newSessionTicket
    case certificate([Certificate])
    case serverKeyExchange
    case certificateRequest
    case serverHelloDone
    case sertificateVerify
    case clientKeyExchange
    case finished
    case certificateUrl
    case certificateStatus
    case supplementalData
}

extension Handshake {
    fileprivate enum RawType: UInt8 {
        case helloRequest = 0
        case clientHello = 1
        case serverHello = 2
        case helloVerifyRequest = 3
        case newSessionTicket = 4
        case certificate = 11
        case serverKeyExchange = 12
        case certificateRequest = 13
        case serverHelloDone = 14
        case sertificateVerify = 15
        case clientKeyExchange = 16
        case finished = 20
        case certificateUrl = 21
        case certificateStatus = 22
        case supplementalData = 23
    }
}

extension Handshake.RawType {
    init<T: UnsafeStreamReader>(from stream: T) throws {
        let rawType = try stream.read(UInt8.self)
        guard let type = Handshake.RawType(rawValue: rawType) else {
            throw TLSError.invalidHandshake
        }
        self = type
    }
}

extension Handshake {
    init<T: UnsafeStreamReader>(from stream: T) throws {
        let type = try RawType(from: stream)
        let length = Int(try stream.read(UInt24.self).byteSwapped)

        // TODO: avoid copying, plaease read NOTE in this extension
        let stream = try InputByteStream(from: stream, byteCount: length)

        switch type {
        case .clientHello: self = .clientHello(try ClientHello(from: stream))
        case .serverHello: self = .serverHello(try ServerHello(from: stream))
        case .certificate: self = .certificate(try [Certificate](from: stream))
        case .serverHelloDone: self = .serverHelloDone
        default: throw TLSError.invalidHandshake
        }
    }
}
