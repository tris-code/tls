/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

import Foundation

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
