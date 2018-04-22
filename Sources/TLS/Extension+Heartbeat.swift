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

public extension Extension {
    public struct Heartbeat: Equatable {
        public enum Mode: UInt8 {
            case allowed = 1
        }
        public let mode: Mode

        public init(mode: Mode) {
            self.mode = mode
        }
    }
}

extension Extension.Heartbeat {
    init(from stream: StreamReader) throws {
        let rawMode = try stream.read(UInt8.self)
        guard let mode = Mode(rawValue: rawMode) else {
            throw TLSError.invalidExtension
        }
        self.mode = mode
    }

    func encode(to stream: StreamWriter) throws {
        try stream.write(mode.rawValue)
    }
}
