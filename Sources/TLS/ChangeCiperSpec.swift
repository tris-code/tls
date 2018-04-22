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

public enum ChangeCiperSpec: UInt8 {
    case `default` = 1
}

extension ChangeCiperSpec {
    init(from stream: StreamReader) throws {
        let rawSpec = try stream.read(UInt8.self)
        guard let spec = ChangeCiperSpec(rawValue: rawSpec) else {
            throw TLSError.invalidChangeCiperSpec
        }
        self = spec
    }

    func encode(to stream: StreamWriter) throws {
        try stream.write(rawValue)
    }
}
