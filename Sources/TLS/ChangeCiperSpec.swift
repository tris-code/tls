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

public enum ChangeCiperSpec: UInt8 {
    case `default` = 1
}

extension ChangeCiperSpec {
    init<T: StreamReader>(from stream: T) throws {
        let rawSpec = try stream.read(UInt8.self)
        guard let spec = ChangeCiperSpec(rawValue: rawSpec) else {
            throw TLSError.invalidChangeCiperSpec
        }
        self = spec
    }
}
