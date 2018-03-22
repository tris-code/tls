/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

import Foundation

struct Session {
    let id: UUID
    let certificate: [UInt8]?
    let compressionMethod: CompressionMethod
    let cipherSpec: CipherSpec
    let masterSecret: [UInt8] // 48-byte secret shared between the client and server.
    let isResumable: Bool
}

struct CipherSpec {
    let cipher: BulkCipherAlgorithm
    let mac: MACAlgorithm
    let type: CipherType
    let isExportable: Bool
    let hashSize: Int
    let keyMaterial: Int
    let ivSize: Int
}

enum BulkCipherAlgorithm {
    case none
    case rc4
    case rc2
    case des
    case des3
    case des40
    case fortezza
}

enum MACAlgorithm {
    case none
    case md5
    case sha
}

enum CipherType {
    case stream
    case block
}
