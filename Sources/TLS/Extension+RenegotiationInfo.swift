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

extension Extension {
    public struct RenegotiationInfo: Equatable {
        let values: [Any]

        public static func ==(
            lhs: RenegotiationInfo,
            rhs: RenegotiationInfo) -> Bool
        {
            return lhs.values.isEmpty == rhs.values.isEmpty
        }
    }
}

extension Extension.RenegotiationInfo {
    init<T: StreamReader>(from stream: T) throws {
        let length = try stream.read(UInt8.self)

        guard length > 0 else {
            self.values = []
            return
        }

        fatalError("not implemented")
    }
}
