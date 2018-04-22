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
    public struct SessionTicket: Equatable {
        public let data: [UInt8]

        public init(data: [UInt8]) {
            self.data = data
        }
    }
}

extension Extension.SessionTicket {
    init(from stream: StreamReader) throws {
        self.data = try stream.readUntilEnd()
    }

    func encode(to stream: StreamWriter) throws {
        try stream.write(data)
    }
}
