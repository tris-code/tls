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
    // ex elliptic_curves
    struct SupportedGroups: Equatable {
        enum Group: UInt16 {
            case sect163k1 = 0x0001
            case sect163r1 = 0x0002
            case sect163r2 = 0x0003
            case sect193r1 = 0x0004
            case sect193r2 = 0x0005
            case sect233k1 = 0x0006
            case sect233r1 = 0x0007
            case sect239k1 = 0x0008
            case sect283k1 = 0x0009
            case sect283r1 = 0x000a
            case sect409k1 = 0x000b
            case sect409r1 = 0x000c
            case sect571k1 = 0x000d
            case sect571r1 = 0x000e
            case secp160k1 = 0x000f
            case secp160r1 = 0x0010
            case secp160r2 = 0x0011
            case secp192k1 = 0x0012
            case secp192r1 = 0x0013
            case secp224k1 = 0x0014
            case secp224r1 = 0x0015
            case secp256k1 = 0x0016
            case secp256r1 = 0x0017
            case secp384r1 = 0x0018
            case secp521r1 = 0x0019
            case brainpoolP256r1 = 0x001a
            case brainpoolP384r1 = 0x001b
            case brainpoolP512r1 = 0x001c
            case ecdh_x25519 = 0x001d // (TEMPORARY - registered 2016-02-29, expires 2017-03-01)
            case ecdh_x448 = 0x001e // (TEMPORARY - registered 2016-02-29, expires 2017-03-01)
            case ffdhe2048 = 0x0100
            case ffdhe3072 = 0x0101
            case ffdhe4096 = 0x0102
            case ffdhe6144 = 0x0103
            case ffdhe8192 = 0x0104
            case arbitrary_explicit_prime_curves = 0xFF01
            case arbitrary_explicit_char2_curves = 0xFF02
        }

        let values: [Group]
    }
}

extension Extension.SupportedGroups {
    init<T: StreamReader>(from stream: T) throws {
        let length = Int(try stream.read(UInt16.self).byteSwapped)

        var groups = [Group]()
        var remain = length
        while remain > 0 {
            let rawGroup = try stream.read(UInt16.self).byteSwapped
            guard let group = Group(rawValue: rawGroup) else {
                throw TLSError.invalidExtension
            }
            groups.append(group)
            remain -= MemoryLayout<UInt16>.size
        }
        self.values = groups
    }
}
