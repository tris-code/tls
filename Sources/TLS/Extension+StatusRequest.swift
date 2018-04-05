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
import Platform

extension Extension {
    public struct StatusRequest: Equatable {
        public enum CertificateStatus: UInt8 {
            case ocsp = 0x01
        }

        public let certificateStatus: CertificateStatus?

        public init(certificateStatus: CertificateStatus?) {
            self.certificateStatus = certificateStatus
        }
    }
}

extension Extension.StatusRequest {
    init<T: StreamReader>(from stream: T) throws {
        let rawStatus = try stream.read(UInt8.self)
        let responderIdListlength = Int(try stream.read(UInt16.self).byteSwapped)
        let requestExtensionsLength = Int(try stream.read(UInt16.self).byteSwapped)

        guard let status = CertificateStatus(rawValue: rawStatus) else {
            throw TLSError.invalidExtension
        }

        guard responderIdListlength == 0 && requestExtensionsLength == 0 else {
            fatalError("not implemented")
        }

        self.certificateStatus = status
    }
}
