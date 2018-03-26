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

struct ClientHello: Equatable {
    let version: ProtocolVersion
    let random: Random
    let sessionId: SessionId // [0..32]
    let ciperSuites: [CiperSuite]
    let compressionMethods: [CompressionMethod]
    let extensions: [Extension]
}

extension ClientHello {
    public init<T: StreamReader>(from stream: T) throws {
        self.version = try ProtocolVersion(from: stream)
        self.random = try Random(from: stream)
        self.sessionId = try SessionId(from: stream)
        self.ciperSuites = try [CiperSuite](from: stream)
        self.compressionMethods = try [CompressionMethod](from: stream)
        self.extensions = try [Extension](from: stream)
    }
}
