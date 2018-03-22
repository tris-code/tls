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

struct ServerHello: Equatable {
    let random: Random
    let sessionId: SessionId // [0..32]
    let ciperSuite: CiperSuite
    let compressionMethod: CompressionMethod
    let extensions: [Extension]
}

extension ServerHello {
    init(ciperSuite: CiperSuite) {
        self.init(sessionId: SessionId(data: []), ciperSuite: ciperSuite)
    }

    init(sessionId: SessionId, ciperSuite: CiperSuite) {
        self.random = Random()
        self.sessionId = sessionId
        self.ciperSuite = ciperSuite
        self.compressionMethod = .none
        self.extensions = []
    }
}

extension ServerHello {
    init<T: UnsafeStreamReader>(from stream: T) throws {
        self.random = try Random(from: stream)
        self.sessionId = try SessionId(from: stream)
        self.ciperSuite = try CiperSuite(from: stream)
        self.compressionMethod = try CompressionMethod(from: stream)
        self.extensions = try [Extension](from: stream)
    }
}
