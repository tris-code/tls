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

public struct ClientKeyExchange: Equatable {
    public let pubkey: [UInt8]

    public init(pubkey: [UInt8]) {
        self.pubkey = pubkey
    }
}

extension ClientKeyExchange {
    init(from stream: StreamReader) throws {
        let length = Int(try stream.read(UInt8.self))
        self.pubkey = try stream.read(count: length)
    }

    func encode(to stream: StreamWriter) throws {
        try stream.write(UInt8(pubkey.count))
        try stream.write(pubkey)
    }
}
