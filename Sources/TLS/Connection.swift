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

// https://tools.ietf.org/html/rfc6101#section-5.1
struct Connection {
    let random: [UInt8]
    let serverMACSecret: [UInt8]
    let clientMACSecret: [UInt8]
    let serverWriteKey: [UInt8]
    let clientWriteKey: [UInt8]
    let initializationVectors: [UInt8]
    let sequenceNumbers: [UInt8]
}
