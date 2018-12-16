/******************************************************************************
 *                                                                            *
 * Tris Foundation disclaims copyright to this source code.                   *
 * In place of a legal notice, here is a blessing:                            *
 *                                                                            *
 *     May you do good and not evil.                                          *
 *     May you find forgiveness for yourself and forgive others.              *
 *     May you share freely, never taking more than you give.                 *
 *                                                                            *
 ******************************************************************************/

import UUID

public struct Session {
    public let id: UUID
    public let certificate: [UInt8]?
    public let compressionMethod: CompressionMethod
    public let cipherSpec: CipherSpec
    public let masterSecret: [UInt8] // 48-byte secret shared between the client and server.
    public let isResumable: Bool
}

public struct CipherSpec {
    public let cipher: BulkCipherAlgorithm
    public let mac: MACAlgorithm
    public let type: CipherType
    public let isExportable: Bool
    public let hashSize: Int
    public let keyMaterial: Int
    public let ivSize: Int
}

public enum BulkCipherAlgorithm {
    case none
    case rc4
    case rc2
    case des
    case des3
    case des40
    case fortezza
}

public enum MACAlgorithm {
    case none
    case md5
    case sha
}

public enum CipherType {
    case stream
    case block
}
