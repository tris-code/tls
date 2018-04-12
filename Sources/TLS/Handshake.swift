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

public enum Handshake: Equatable {
    case helloRequest
    case clientHello(ClientHello)
    case serverHello(ServerHello)
    case helloVerifyRequest
    case newSessionTicket
    case certificate([Certificate])
    case serverKeyExchange(ServerKeyExchange)
    case certificateRequest
    case serverHelloDone
    case certificateVerify
    case clientKeyExchange(ClientKeyExchange)
    case finished
    case certificateUrl
    case certificateStatus(Certificate.Status)
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
    init(from stream: StreamReader) throws {
        let rawType = try stream.read(UInt8.self)
        guard let type = Handshake.RawType(rawValue: rawType) else {
            throw TLSError.invalidHandshake
        }
        self = type
    }

    func encode(to stream: StreamWriter) throws {
        try stream.write(self.rawValue)
    }
}

extension Handshake {
    init(from stream: StreamReader) throws {
        let type = try RawType(from: stream)
        self = try stream.withSubStream(sizedBy: UInt24.self) { stream in
            switch type {
            case .clientHello:
                return .clientHello(try ClientHello(from: stream))
            case .serverHello:
                return .serverHello(try ServerHello(from: stream))
            case .certificate:
                return .certificate(try [Certificate](from: stream))
            case .serverKeyExchange:
                return .serverKeyExchange(try ServerKeyExchange(from: stream))
            case .clientKeyExchange:
                return .clientKeyExchange(try ClientKeyExchange(from: stream))
            case .certificateStatus:
                return .certificateStatus(try Certificate.Status(from: stream))
            case .serverHelloDone:
                return .serverHelloDone
            default:
                throw TLSError.invalidHandshake
            }
        }
    }

    func encode(to stream: StreamWriter) throws {
        func write(rawType type: RawType) throws {
            try type.encode(to: stream)
        }
        switch self {
        case .clientHello: try write(rawType: .clientHello)
        case .serverHello: try write(rawType: .serverHello)
        case .certificate: try write(rawType: .certificate)
        case .serverKeyExchange: try write(rawType: .serverKeyExchange)
        case .clientKeyExchange: try write(rawType: .clientKeyExchange)
        case .serverHelloDone: try write(rawType: .serverHelloDone)
        default: fatalError("not implemented")
        }

        try stream.withSubStream(sizedBy: UInt24.self) { stream in
            switch self {
            case .clientHello(let hello): try hello.encode(to: stream)
            case .serverHello(let hello): try hello.encode(to: stream)
            case .serverKeyExchange(let data): try data.encode(to: stream)
            case .clientKeyExchange(let data): try data.encode(to: stream)
            case .certificate(let data): try data.encode(to: stream)
            case .serverHelloDone: return
            default: fatalError("not implemented")
            }
        }
    }
}
