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

extension InputByteStream {
    // NOTE:
    // maybe we should add something like:
    // <StreamReader>.setMaxInputBytes(count: )
    convenience
    init<T: StreamReader>(from stream: T, byteCount: Int) throws {
        self.init(try stream.read(count: byteCount))
    }
}
