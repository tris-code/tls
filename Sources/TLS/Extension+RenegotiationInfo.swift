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

extension Extension {
    public struct RenegotiationInfo: Equatable {
        let renegotiatedConnection: [UInt8]

        public init(renegotiatedConnection: [UInt8] = []) {
            self.renegotiatedConnection = renegotiatedConnection
        }
    }
}

extension Extension.RenegotiationInfo {
    init(from stream: StreamReader) throws {
        let length = Int(try stream.read(UInt8.self))
        guard length > 0 else {
            self.renegotiatedConnection = []
            return
        }
        self.renegotiatedConnection = try stream.read(count: length)
    }

    func encode(to stream: StreamWriter) throws {
        guard renegotiatedConnection.count > 0 else {
            try stream.write(UInt8(0))
            return
        }
        try stream.write(UInt8(renegotiatedConnection.count))
        try stream.write(renegotiatedConnection)
    }
}
