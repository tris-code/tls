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

public enum TLSError: Error {
    case invalidRecordContentType
    case invalidProtocolVerion
    case invalidHandshake
    case invalidCertificateStatus
    case invalidCiperSuitesLength
    case invalidCiperSuite
    case invalidCompressionMethod
    case invalidExtension
    case invalidChangeCiperSpec
    case invalidAlert
}
