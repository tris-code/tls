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

import Stream

extension RawRepresentable where RawValue == UInt8 {
    @inline(__always)
    init?(from stream: StreamReader) throws {
        let rawType = try stream.read(UInt8.self)
        self.init(rawValue: rawType)
    }

    @inline(__always)
    func encode(to stream: StreamWriter) throws {
        try stream.write(rawValue)
    }
}
