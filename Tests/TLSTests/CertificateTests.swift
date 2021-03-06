import Test
import Stream
@testable import TLS

class CertificateTests: TestCase {
    let header: [UInt8] = [
        // handshake
        0x16,
        // tls 1.2
        0x03, 0x03,
        // length: 4455
        0x11, 0x67,
        // handshake type: certificate
        0x0b,
        // length: 4451
        0x00, 0x11, 0x63,
        // certificates length: 4448
        0x00, 0x11, 0x60
    ]

    /*  Certificates */

    let certificate1: [UInt8] = [
        // length: 2035
        0x00, 0x07, 0xf3,
        // certificate
        0x30,
        0x82, 0x07, 0xef, 0x30, 0x82, 0x06, 0xd7, 0xa0,
        0x03, 0x02, 0x01, 0x02, 0x02, 0x10, 0x62, 0xfa,
        0x7d, 0x18, 0x39, 0x8c, 0x6e, 0x14, 0xec, 0x17,
        0xc6, 0xfa, 0x50, 0x77, 0x75, 0xdf, 0x30, 0x0d,
        0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d,
        0x01, 0x01, 0x0b, 0x05, 0x00, 0x30, 0x5f, 0x31,
        0x0b, 0x30, 0x09, 0x06, 0x03, 0x55, 0x04, 0x06,
        0x13, 0x02, 0x52, 0x55, 0x31, 0x13, 0x30, 0x11,
        0x06, 0x03, 0x55, 0x04, 0x0a, 0x13, 0x0a, 0x59,
        0x61, 0x6e, 0x64, 0x65, 0x78, 0x20, 0x4c, 0x4c,
        0x43, 0x31, 0x27, 0x30, 0x25, 0x06, 0x03, 0x55,
        0x04, 0x0b, 0x13, 0x1e, 0x59, 0x61, 0x6e, 0x64,
        0x65, 0x78, 0x20, 0x43, 0x65, 0x72, 0x74, 0x69,
        0x66, 0x69, 0x63, 0x61, 0x74, 0x69, 0x6f, 0x6e,
        0x20, 0x41, 0x75, 0x74, 0x68, 0x6f, 0x72, 0x69,
        0x74, 0x79, 0x31, 0x12, 0x30, 0x10, 0x06, 0x03,
        0x55, 0x04, 0x03, 0x13, 0x09, 0x59, 0x61, 0x6e,
        0x64, 0x65, 0x78, 0x20, 0x43, 0x41, 0x30, 0x1e,
        0x17, 0x0d, 0x31, 0x36, 0x30, 0x35, 0x31, 0x33,
        0x31, 0x32, 0x31, 0x39, 0x31, 0x35, 0x5a, 0x17,
        0x0d, 0x31, 0x38, 0x30, 0x35, 0x31, 0x33, 0x31,
        0x32, 0x31, 0x39, 0x31, 0x35, 0x5a, 0x30, 0x7b,
        0x31, 0x0b, 0x30, 0x09, 0x06, 0x03, 0x55, 0x04,
        0x06, 0x13, 0x02, 0x52, 0x55, 0x31, 0x13, 0x30,
        0x11, 0x06, 0x03, 0x55, 0x04, 0x0a, 0x0c, 0x0a,
        0x59, 0x61, 0x6e, 0x64, 0x65, 0x78, 0x20, 0x4c,
        0x4c, 0x43, 0x31, 0x0c, 0x30, 0x0a, 0x06, 0x03,
        0x55, 0x04, 0x0b, 0x0c, 0x03, 0x49, 0x54, 0x4f,
        0x31, 0x0f, 0x30, 0x0d, 0x06, 0x03, 0x55, 0x04,
        0x07, 0x0c, 0x06, 0x4d, 0x6f, 0x73, 0x63, 0x6f,
        0x77, 0x31, 0x1b, 0x30, 0x19, 0x06, 0x03, 0x55,
        0x04, 0x08, 0x0c, 0x12, 0x52, 0x75, 0x73, 0x73,
        0x69, 0x61, 0x6e, 0x20, 0x46, 0x65, 0x64, 0x65,
        0x72, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x31, 0x1b,
        0x30, 0x19, 0x06, 0x03, 0x55, 0x04, 0x03, 0x0c,
        0x12, 0x2a, 0x2e, 0x77, 0x66, 0x61, 0x72, 0x6d,
        0x2e, 0x79, 0x61, 0x6e, 0x64, 0x65, 0x78, 0x2e,
        0x6e, 0x65, 0x74, 0x30, 0x82, 0x01, 0x22, 0x30,
        0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7,
        0x0d, 0x01, 0x01, 0x01, 0x05, 0x00, 0x03, 0x82,
        0x01, 0x0f, 0x00, 0x30, 0x82, 0x01, 0x0a, 0x02,
        0x82, 0x01, 0x01, 0x00, 0xdf, 0x8b, 0x73, 0x06,
        0x95, 0xff, 0x53, 0x9a, 0xcb, 0x03, 0xab, 0xd2,
        0xe0, 0xfd, 0x3e, 0x3e, 0xdb, 0x02, 0x95, 0x0f,
        0x85, 0xd0, 0x31, 0xfd, 0x44, 0x5e, 0xcb, 0xa9,
        0xd0, 0xae, 0x57, 0x51, 0x16, 0x3b, 0x18, 0x3e,
        0x80, 0xc0, 0x57, 0x1f, 0x7c, 0xdb, 0x11, 0x3b,
        0x2e, 0x9d, 0x47, 0xff, 0xe1, 0x18, 0x41, 0x03,
        0xbc, 0xbb, 0x51, 0xed, 0x74, 0xd2, 0x77, 0xcf,
        0x33, 0xbc, 0x59, 0x2e, 0x4b, 0x48, 0xf5, 0x4d,
        0x05, 0xe8, 0x3e, 0x17, 0x14, 0x95, 0x7d, 0xf9,
        0x8c, 0x1c, 0x84, 0x2f, 0xfd, 0xae, 0x20, 0xe9,
        0xa2, 0x36, 0xa5, 0x0b, 0x48, 0xea, 0x78, 0xbb,
        0x59, 0xdf, 0x76, 0x83, 0xe4, 0x8c, 0x75, 0xe5,
        0x29, 0x93, 0x91, 0x72, 0xa9, 0x44, 0xd0, 0x7b,
        0x14, 0xed, 0x8d, 0xe4, 0x71, 0x92, 0x33, 0x60,
        0x5b, 0xc0, 0xa1, 0x0e, 0xb3, 0x92, 0x7d, 0x96,
        0xeb, 0x0f, 0x57, 0x9c, 0x1c, 0xff, 0x88, 0x59,
        0xc9, 0x38, 0x19, 0x86, 0x55, 0x3e, 0xf7, 0xd0,
        0x54, 0x15, 0x1e, 0x34, 0xc1, 0x2e, 0x67, 0x6e,
        0x6d, 0x36, 0xb3, 0x9e, 0xdd, 0x96, 0x24, 0x5d,
        0xdc, 0x5e, 0x7e, 0x41, 0xcb, 0x7d, 0x33, 0x10,
        0x94, 0x3e, 0x52, 0xcb, 0x3f, 0xbd, 0x11, 0x21,
        0xf6, 0xd4, 0x89, 0xac, 0xdd, 0xb7, 0xa4, 0x17,
        0x0d, 0x2f, 0xd5, 0xb4, 0xba, 0x59, 0x8d, 0x52,
        0x9e, 0x7c, 0xc1, 0xd4, 0x99, 0xfa, 0x51, 0xb7,
        0xfc, 0x93, 0x98, 0x52, 0x7d, 0xb5, 0x15, 0x8a,
        0xe8, 0xb5, 0x36, 0x66, 0x0e, 0x2b, 0xdf, 0xf1,
        0x8b, 0x55, 0x9e, 0xeb, 0xcf, 0xd3, 0xb0, 0x4e,
        0xb1, 0x8c, 0x47, 0x40, 0xc5, 0xc9, 0x61, 0x16,
        0x8e, 0xb1, 0xfb, 0x42, 0x1c, 0x62, 0xcb, 0x79,
        0xdd, 0x5d, 0x3d, 0x6a, 0x87, 0xfd, 0xc1, 0x32,
        0x41, 0x04, 0xd7, 0x29, 0x6c, 0xf2, 0x3f, 0x3e,
        0x28, 0x74, 0xb7, 0xdb, 0x02, 0x03, 0x01, 0x00,
        0x01, 0xa3, 0x82, 0x04, 0x89, 0x30, 0x82, 0x04,
        0x85, 0x30, 0x0c, 0x06, 0x03, 0x55, 0x1d, 0x13,
        0x01, 0x01, 0xff, 0x04, 0x02, 0x30, 0x00, 0x30,
        0x69, 0x06, 0x03, 0x55, 0x1d, 0x1f, 0x04, 0x62,
        0x30, 0x60, 0x30, 0x2f, 0xa0, 0x2d, 0xa0, 0x2b,
        0x86, 0x29, 0x68, 0x74, 0x74, 0x70, 0x3a, 0x2f,
        0x2f, 0x63, 0x72, 0x6c, 0x73, 0x2e, 0x79, 0x61,
        0x6e, 0x64, 0x65, 0x78, 0x2e, 0x6e, 0x65, 0x74,
        0x2f, 0x63, 0x65, 0x72, 0x74, 0x75, 0x6d, 0x2f,
        0x79, 0x63, 0x61, 0x73, 0x68, 0x61, 0x32, 0x2e,
        0x63, 0x72, 0x6c, 0x30, 0x2d, 0xa0, 0x2b, 0xa0,
        0x29, 0x86, 0x27, 0x68, 0x74, 0x74, 0x70, 0x3a,
        0x2f, 0x2f, 0x79, 0x61, 0x6e, 0x64, 0x65, 0x78,
        0x2e, 0x63, 0x72, 0x6c, 0x2e, 0x63, 0x65, 0x72,
        0x74, 0x75, 0x6d, 0x2e, 0x70, 0x6c, 0x2f, 0x79,
        0x63, 0x61, 0x73, 0x68, 0x61, 0x32, 0x2e, 0x63,
        0x72, 0x6c, 0x30, 0x71, 0x06, 0x08, 0x2b, 0x06,
        0x01, 0x05, 0x05, 0x07, 0x01, 0x01, 0x04, 0x65,
        0x30, 0x63, 0x30, 0x2c, 0x06, 0x08, 0x2b, 0x06,
        0x01, 0x05, 0x05, 0x07, 0x30, 0x01, 0x86, 0x20,
        0x68, 0x74, 0x74, 0x70, 0x3a, 0x2f, 0x2f, 0x79,
        0x61, 0x6e, 0x64, 0x65, 0x78, 0x2e, 0x6f, 0x63,
        0x73, 0x70, 0x2d, 0x72, 0x65, 0x73, 0x70, 0x6f,
        0x6e, 0x64, 0x65, 0x72, 0x2e, 0x63, 0x6f, 0x6d,
        0x30, 0x33, 0x06, 0x08, 0x2b, 0x06, 0x01, 0x05,
        0x05, 0x07, 0x30, 0x02, 0x86, 0x27, 0x68, 0x74,
        0x74, 0x70, 0x3a, 0x2f, 0x2f, 0x72, 0x65, 0x70,
        0x6f, 0x73, 0x69, 0x74, 0x6f, 0x72, 0x79, 0x2e,
        0x63, 0x65, 0x72, 0x74, 0x75, 0x6d, 0x2e, 0x70,
        0x6c, 0x2f, 0x79, 0x63, 0x61, 0x73, 0x68, 0x61,
        0x32, 0x2e, 0x63, 0x65, 0x72, 0x30, 0x1f, 0x06,
        0x03, 0x55, 0x1d, 0x23, 0x04, 0x18, 0x30, 0x16,
        0x80, 0x14, 0x37, 0x5c, 0xe3, 0x19, 0xe0, 0xb2,
        0x8e, 0xa1, 0xa8, 0x4e, 0xd2, 0xcf, 0xab, 0xd0,
        0xdc, 0xe3, 0x0b, 0x5c, 0x35, 0x4d, 0x30, 0x1d,
        0x06, 0x03, 0x55, 0x1d, 0x0e, 0x04, 0x16, 0x04,
        0x14, 0x70, 0x4c, 0x43, 0x15, 0x1b, 0x26, 0x78,
        0x74, 0x0c, 0x6f, 0xcc, 0x53, 0xdf, 0x41, 0x23,
        0xc4, 0x97, 0xe9, 0x63, 0x73, 0x30, 0x0e, 0x06,
        0x03, 0x55, 0x1d, 0x0f, 0x01, 0x01, 0xff, 0x04,
        0x04, 0x03, 0x02, 0x05, 0xa0, 0x30, 0x82, 0x01,
        0x3f, 0x06, 0x03, 0x55, 0x1d, 0x20, 0x04, 0x82,
        0x01, 0x36, 0x30, 0x82, 0x01, 0x32, 0x30, 0x82,
        0x01, 0x2e, 0x06, 0x0c, 0x2a, 0x84, 0x68, 0x01,
        0x86, 0xf6, 0x77, 0x02, 0x05, 0x01, 0x0a, 0x02,
        0x30, 0x82, 0x01, 0x1c, 0x30, 0x25, 0x06, 0x08,
        0x2b, 0x06, 0x01, 0x05, 0x05, 0x07, 0x02, 0x01,
        0x16, 0x19, 0x68, 0x74, 0x74, 0x70, 0x73, 0x3a,
        0x2f, 0x2f, 0x77, 0x77, 0x77, 0x2e, 0x63, 0x65,
        0x72, 0x74, 0x75, 0x6d, 0x2e, 0x70, 0x6c, 0x2f,
        0x43, 0x50, 0x53, 0x30, 0x81, 0xf2, 0x06, 0x08,
        0x2b, 0x06, 0x01, 0x05, 0x05, 0x07, 0x02, 0x02,
        0x30, 0x81, 0xe5, 0x30, 0x20, 0x16, 0x19, 0x55,
        0x6e, 0x69, 0x7a, 0x65, 0x74, 0x6f, 0x20, 0x54,
        0x65, 0x63, 0x68, 0x6e, 0x6f, 0x6c, 0x6f, 0x67,
        0x69, 0x65, 0x73, 0x20, 0x53, 0x2e, 0x41, 0x2e,
        0x30, 0x03, 0x02, 0x01, 0x02, 0x1a, 0x81, 0xc0,
        0x55, 0x73, 0x61, 0x67, 0x65, 0x20, 0x6f, 0x66,
        0x20, 0x74, 0x68, 0x69, 0x73, 0x20, 0x63, 0x65,
        0x72, 0x74, 0x69, 0x66, 0x69, 0x63, 0x61, 0x74,
        0x65, 0x20, 0x69, 0x73, 0x20, 0x73, 0x74, 0x72,
        0x69, 0x63, 0x74, 0x6c, 0x79, 0x20, 0x73, 0x75,
        0x62, 0x6a, 0x65, 0x63, 0x74, 0x65, 0x64, 0x20,
        0x74, 0x6f, 0x20, 0x74, 0x68, 0x65, 0x20, 0x43,
        0x45, 0x52, 0x54, 0x55, 0x4d, 0x20, 0x43, 0x65,
        0x72, 0x74, 0x69, 0x66, 0x69, 0x63, 0x61, 0x74,
        0x69, 0x6f, 0x6e, 0x20, 0x50, 0x72, 0x61, 0x63,
        0x74, 0x69, 0x63, 0x65, 0x20, 0x53, 0x74, 0x61,
        0x74, 0x65, 0x6d, 0x65, 0x6e, 0x74, 0x20, 0x28,
        0x43, 0x50, 0x53, 0x29, 0x20, 0x69, 0x6e, 0x63,
        0x6f, 0x72, 0x70, 0x6f, 0x72, 0x61, 0x74, 0x65,
        0x64, 0x20, 0x62, 0x79, 0x20, 0x72, 0x65, 0x66,
        0x65, 0x72, 0x65, 0x6e, 0x63, 0x65, 0x20, 0x68,
        0x65, 0x72, 0x65, 0x69, 0x6e, 0x20, 0x61, 0x6e,
        0x64, 0x20, 0x69, 0x6e, 0x20, 0x74, 0x68, 0x65,
        0x20, 0x72, 0x65, 0x70, 0x6f, 0x73, 0x69, 0x74,
        0x6f, 0x72, 0x79, 0x20, 0x61, 0x74, 0x20, 0x68,
        0x74, 0x74, 0x70, 0x73, 0x3a, 0x2f, 0x2f, 0x77,
        0x77, 0x77, 0x2e, 0x63, 0x65, 0x72, 0x74, 0x75,
        0x6d, 0x2e, 0x70, 0x6c, 0x2f, 0x72, 0x65, 0x70,
        0x6f, 0x73, 0x69, 0x74, 0x6f, 0x72, 0x79, 0x2e,
        0x30, 0x1d, 0x06, 0x03, 0x55, 0x1d, 0x25, 0x04,
        0x16, 0x30, 0x14, 0x06, 0x08, 0x2b, 0x06, 0x01,
        0x05, 0x05, 0x07, 0x03, 0x01, 0x06, 0x08, 0x2b,
        0x06, 0x01, 0x05, 0x05, 0x07, 0x03, 0x02, 0x30,
        0x11, 0x06, 0x09, 0x60, 0x86, 0x48, 0x01, 0x86,
        0xf8, 0x42, 0x01, 0x01, 0x04, 0x04, 0x03, 0x02,
        0x06, 0xc0, 0x30, 0x82, 0x01, 0xd0, 0x06, 0x03,
        0x55, 0x1d, 0x11, 0x04, 0x82, 0x01, 0xc7, 0x30,
        0x82, 0x01, 0xc3, 0x82, 0x0d, 0x6f, 0x6c, 0x64,
        0x2e, 0x79, 0x61, 0x6e, 0x64, 0x65, 0x78, 0x2e,
        0x72, 0x75, 0x82, 0x12, 0x2a, 0x2e, 0x77, 0x66,
        0x61, 0x72, 0x6d, 0x2e, 0x79, 0x61, 0x6e, 0x64,
        0x65, 0x78, 0x2e, 0x6e, 0x65, 0x74, 0x82, 0x0b,
        0x6d, 0x2e, 0x79, 0x61, 0x6e, 0x64, 0x65, 0x78,
        0x2e, 0x62, 0x79, 0x82, 0x10, 0x66, 0x61, 0x6d,
        0x69, 0x6c, 0x79, 0x2e, 0x79, 0x61, 0x6e, 0x64,
        0x65, 0x78, 0x2e, 0x62, 0x79, 0x82, 0x0d, 0x77,
        0x77, 0x77, 0x2e, 0x79, 0x61, 0x6e, 0x64, 0x65,
        0x78, 0x2e, 0x72, 0x75, 0x82, 0x0d, 0x6e, 0x65,
        0x77, 0x2e, 0x79, 0x61, 0x6e, 0x64, 0x65, 0x78,
        0x2e, 0x72, 0x75, 0x82, 0x05, 0x79, 0x61, 0x2e,
        0x72, 0x75, 0x82, 0x10, 0x77, 0x66, 0x61, 0x72,
        0x6d, 0x2e, 0x79, 0x61, 0x6e, 0x64, 0x65, 0x78,
        0x2e, 0x6e, 0x65, 0x74, 0x82, 0x0d, 0x70, 0x64,
        0x61, 0x2e, 0x79, 0x61, 0x6e, 0x64, 0x65, 0x78,
        0x2e, 0x72, 0x75, 0x82, 0x0b, 0x6d, 0x2e, 0x79,
        0x61, 0x6e, 0x64, 0x65, 0x78, 0x2e, 0x6b, 0x7a,
        0x82, 0x10, 0x66, 0x61, 0x6d, 0x69, 0x6c, 0x79,
        0x2e, 0x79, 0x61, 0x6e, 0x64, 0x65, 0x78, 0x2e,
        0x75, 0x61, 0x82, 0x10, 0x66, 0x61, 0x6d, 0x69,
        0x6c, 0x79, 0x2e, 0x79, 0x61, 0x6e, 0x64, 0x65,
        0x78, 0x2e, 0x6b, 0x7a, 0x82, 0x09, 0x77, 0x77,
        0x77, 0x2e, 0x79, 0x61, 0x2e, 0x72, 0x75, 0x82,
        0x0c, 0x77, 0x77, 0x2e, 0x79, 0x61, 0x6e, 0x64,
        0x65, 0x78, 0x2e, 0x72, 0x75, 0x82, 0x0b, 0x6d,
        0x2e, 0x79, 0x61, 0x6e, 0x64, 0x65, 0x78, 0x2e,
        0x75, 0x61, 0x82, 0x10, 0x66, 0x61, 0x6d, 0x69,
        0x6c, 0x79, 0x2e, 0x79, 0x61, 0x6e, 0x64, 0x65,
        0x78, 0x2e, 0x72, 0x75, 0x82, 0x11, 0x66, 0x69,
        0x72, 0x65, 0x66, 0x6f, 0x78, 0x2e, 0x79, 0x61,
        0x6e, 0x64, 0x65, 0x78, 0x2e, 0x72, 0x75, 0x82,
        0x10, 0x73, 0x63, 0x68, 0x6f, 0x6f, 0x6c, 0x2e,
        0x79, 0x61, 0x6e, 0x64, 0x65, 0x78, 0x2e, 0x72,
        0x75, 0x82, 0x12, 0x6b, 0x65, 0x79, 0x62, 0x6f,
        0x61, 0x72, 0x64, 0x2e, 0x79, 0x61, 0x6e, 0x64,
        0x65, 0x78, 0x2e, 0x72, 0x75, 0x82, 0x0c, 0x68,
        0x77, 0x2e, 0x79, 0x61, 0x6e, 0x64, 0x65, 0x78,
        0x2e, 0x72, 0x75, 0x82, 0x15, 0x66, 0x69, 0x72,
        0x65, 0x66, 0x6f, 0x78, 0x2e, 0x79, 0x61, 0x6e,
        0x64, 0x65, 0x78, 0x2e, 0x63, 0x6f, 0x6d, 0x2e,
        0x74, 0x72, 0x82, 0x0c, 0x6f, 0x70, 0x2e, 0x79,
        0x61, 0x6e, 0x64, 0x65, 0x78, 0x2e, 0x72, 0x75,
        0x82, 0x11, 0x66, 0x69, 0x72, 0x65, 0x66, 0x6f,
        0x78, 0x2e, 0x79, 0x61, 0x6e, 0x64, 0x65, 0x78,
        0x2e, 0x75, 0x61, 0x82, 0x0d, 0x77, 0x77, 0x77,
        0x2e, 0x79, 0x61, 0x6e, 0x64, 0x65, 0x78, 0x2e,
        0x62, 0x79, 0x82, 0x0e, 0x77, 0x77, 0x77, 0x77,
        0x2e, 0x79, 0x61, 0x6e, 0x64, 0x65, 0x78, 0x2e,
        0x72, 0x75, 0x82, 0x0b, 0x6d, 0x2e, 0x79, 0x61,
        0x6e, 0x64, 0x65, 0x78, 0x2e, 0x72, 0x75, 0x82,
        0x0d, 0x77, 0x77, 0x77, 0x2e, 0x79, 0x61, 0x6e,
        0x64, 0x65, 0x78, 0x2e, 0x6b, 0x7a, 0x82, 0x07,
        0x6d, 0x2e, 0x79, 0x61, 0x2e, 0x72, 0x75, 0x82,
        0x0d, 0x77, 0x77, 0x77, 0x2e, 0x79, 0x61, 0x6e,
        0x64, 0x65, 0x78, 0x2e, 0x75, 0x61, 0x30, 0x0d,
        0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d,
        0x01, 0x01, 0x0b, 0x05, 0x00, 0x03, 0x82, 0x01,
        0x01, 0x00, 0x64, 0x45, 0x1f, 0xa8, 0x32, 0x39,
        0x72, 0xce, 0x2d, 0xee, 0x0b, 0x08, 0x33, 0xf1,
        0x23, 0x21, 0xa0, 0x8e, 0x47, 0xd7, 0xfd, 0x43,
        0xf2, 0xa4, 0x03, 0x06, 0x41, 0x3c, 0x01, 0xef,
        0x9f, 0x61, 0x68, 0x81, 0x1c, 0x3a, 0xd5, 0x18,
        0xa5, 0x30, 0xa2, 0xc8, 0x9d, 0x83, 0xb6, 0xb9,
        0xbe, 0x2d, 0x8a, 0x73, 0x58, 0x5c, 0x1d, 0x74,
        0x8a, 0x20, 0x8a, 0xf0, 0x80, 0x25, 0xb5, 0x46,
        0x00, 0xdf, 0x83, 0x80, 0x19, 0xcb, 0xd5, 0xac,
        0x6b, 0x5d, 0x2d, 0x27, 0xa6, 0x69, 0x4b, 0x6d,
        0x8e, 0x6a, 0xac, 0x0e, 0xcc, 0x15, 0x18, 0xf6,
        0x15, 0xf9, 0x1c, 0xd3, 0xb2, 0x4f, 0x66, 0x36,
        0xc6, 0xb1, 0xf1, 0xb1, 0xae, 0x4b, 0x4a, 0x67,
        0xaa, 0x30, 0x79, 0xe4, 0xeb, 0x85, 0xcd, 0x8f,
        0xba, 0x75, 0x82, 0x4a, 0xc4, 0x82, 0x0b, 0x04,
        0x2c, 0xc0, 0x27, 0x1b, 0xf1, 0xe9, 0x82, 0xad,
        0x1d, 0x5c, 0xdc, 0xdb, 0x08, 0xa4, 0x04, 0xa2,
        0x5a, 0x07, 0x30, 0xf0, 0xae, 0xea, 0xfb, 0xe5,
        0x9d, 0x0e, 0x9b, 0xa8, 0x03, 0x4f, 0x37, 0x39,
        0x01, 0x68, 0xbe, 0x0a, 0x18, 0xbb, 0x2d, 0xc0,
        0x0f, 0x7a, 0x90, 0x29, 0x8c, 0xbd, 0x3b, 0xe2,
        0x9d, 0x2a, 0xb2, 0x78, 0x7b, 0xcb, 0xc1, 0xe4,
        0xd0, 0xc1, 0x15, 0x21, 0x60, 0x48, 0xef, 0x2f,
        0xc8, 0xc2, 0xdc, 0x2b, 0xbb, 0x13, 0xca, 0xe5,
        0x0a, 0x8e, 0x50, 0x4a, 0xbb, 0xcf, 0xdc, 0xf2,
        0xe8, 0xcd, 0xdd, 0x4c, 0x54, 0x6c, 0x76, 0xd3,
        0xdb, 0x3c, 0x80, 0xd9, 0xec, 0xde, 0x3d, 0xad,
        0x87, 0x8f, 0x80, 0x83, 0x37, 0x93, 0xde, 0x87,
        0x5f, 0x88, 0x23, 0x11, 0x53, 0x8d, 0xf7, 0xf8,
        0x28, 0xb6, 0x2a, 0x94, 0x40, 0x76, 0xbc, 0x73,
        0x24, 0x37, 0x65, 0x0f, 0xd8, 0x24, 0x92, 0x1b,
        0x54, 0x76, 0x1c, 0xb0, 0x4c, 0xaa, 0x4c, 0x40,
        0x5b, 0x8b
    ]

    let certificate2: [UInt8] = [
        // length: 1196
        0x00, 0x04, 0xac,
        // certificate
        0x30, 0x82, 0x04,
        0xa8, 0x30, 0x82, 0x03, 0x90, 0xa0, 0x03, 0x02,
        0x01, 0x02, 0x02, 0x11, 0x00, 0xe4, 0x05, 0x47,
        0x83, 0x0e, 0x0c, 0x64, 0x52, 0x97, 0x6f, 0x7a,
        0x35, 0x49, 0xc0, 0xdd, 0x48, 0x30, 0x0d, 0x06,
        0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01,
        0x01, 0x0b, 0x05, 0x00, 0x30, 0x7e, 0x31, 0x0b,
        0x30, 0x09, 0x06, 0x03, 0x55, 0x04, 0x06, 0x13,
        0x02, 0x50, 0x4c, 0x31, 0x22, 0x30, 0x20, 0x06,
        0x03, 0x55, 0x04, 0x0a, 0x13, 0x19, 0x55, 0x6e,
        0x69, 0x7a, 0x65, 0x74, 0x6f, 0x20, 0x54, 0x65,
        0x63, 0x68, 0x6e, 0x6f, 0x6c, 0x6f, 0x67, 0x69,
        0x65, 0x73, 0x20, 0x53, 0x2e, 0x41, 0x2e, 0x31,
        0x27, 0x30, 0x25, 0x06, 0x03, 0x55, 0x04, 0x0b,
        0x13, 0x1e, 0x43, 0x65, 0x72, 0x74, 0x75, 0x6d,
        0x20, 0x43, 0x65, 0x72, 0x74, 0x69, 0x66, 0x69,
        0x63, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x20, 0x41,
        0x75, 0x74, 0x68, 0x6f, 0x72, 0x69, 0x74, 0x79,
        0x31, 0x22, 0x30, 0x20, 0x06, 0x03, 0x55, 0x04,
        0x03, 0x13, 0x19, 0x43, 0x65, 0x72, 0x74, 0x75,
        0x6d, 0x20, 0x54, 0x72, 0x75, 0x73, 0x74, 0x65,
        0x64, 0x20, 0x4e, 0x65, 0x74, 0x77, 0x6f, 0x72,
        0x6b, 0x20, 0x43, 0x41, 0x30, 0x1e, 0x17, 0x0d,
        0x31, 0x35, 0x30, 0x31, 0x32, 0x31, 0x31, 0x32,
        0x30, 0x30, 0x30, 0x30, 0x5a, 0x17, 0x0d, 0x32,
        0x35, 0x30, 0x31, 0x31, 0x38, 0x31, 0x32, 0x30,
        0x30, 0x30, 0x30, 0x5a, 0x30, 0x5f, 0x31, 0x0b,
        0x30, 0x09, 0x06, 0x03, 0x55, 0x04, 0x06, 0x13,
        0x02, 0x52, 0x55, 0x31, 0x13, 0x30, 0x11, 0x06,
        0x03, 0x55, 0x04, 0x0a, 0x13, 0x0a, 0x59, 0x61,
        0x6e, 0x64, 0x65, 0x78, 0x20, 0x4c, 0x4c, 0x43,
        0x31, 0x27, 0x30, 0x25, 0x06, 0x03, 0x55, 0x04,
        0x0b, 0x13, 0x1e, 0x59, 0x61, 0x6e, 0x64, 0x65,
        0x78, 0x20, 0x43, 0x65, 0x72, 0x74, 0x69, 0x66,
        0x69, 0x63, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x20,
        0x41, 0x75, 0x74, 0x68, 0x6f, 0x72, 0x69, 0x74,
        0x79, 0x31, 0x12, 0x30, 0x10, 0x06, 0x03, 0x55,
        0x04, 0x03, 0x13, 0x09, 0x59, 0x61, 0x6e, 0x64,
        0x65, 0x78, 0x20, 0x43, 0x41, 0x30, 0x82, 0x01,
        0x22, 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48,
        0x86, 0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00,
        0x03, 0x82, 0x01, 0x0f, 0x00, 0x30, 0x82, 0x01,
        0x0a, 0x02, 0x82, 0x01, 0x01, 0x00, 0xa6, 0x05,
        0x24, 0x76, 0x61, 0xb9, 0x9e, 0x42, 0x60, 0x22,
        0x63, 0x85, 0x59, 0xe5, 0x9d, 0x88, 0x0d, 0xdf,
        0xef, 0x21, 0x64, 0x5a, 0x26, 0x94, 0x71, 0x3a,
        0xa4, 0x7f, 0x2b, 0x53, 0xc3, 0xac, 0x7b, 0xba,
        0x95, 0x42, 0x6d, 0x6a, 0x5b, 0xd6, 0x7e, 0x78,
        0x0c, 0x67, 0x40, 0x98, 0x2f, 0x6a, 0x2d, 0xd0,
        0xb7, 0x18, 0x3a, 0x7e, 0x99, 0x60, 0x01, 0xe5,
        0x27, 0xbf, 0xff, 0x49, 0xf5, 0xcd, 0xc4, 0x58,
        0xc3, 0x4c, 0xe1, 0x70, 0xd5, 0xfd, 0x08, 0xa8,
        0x79, 0x95, 0x76, 0x1c, 0x0e, 0x05, 0x41, 0xfa,
        0xbd, 0x80, 0x38, 0x2a, 0x87, 0x4f, 0xc1, 0x67,
        0x42, 0xaa, 0x17, 0xa6, 0xee, 0xa7, 0x8c, 0x8e,
        0xef, 0x2d, 0x7f, 0x7a, 0x1d, 0x05, 0x17, 0x8f,
        0x7e, 0x3b, 0x92, 0x35, 0xf5, 0x68, 0xed, 0x93,
        0x03, 0x55, 0x23, 0x4f, 0x4b, 0xa2, 0x00, 0x86,
        0x65, 0x91, 0x0f, 0xeb, 0xf6, 0x3c, 0xd5, 0xdb,
        0x6d, 0x0e, 0xed, 0xe8, 0x7c, 0x3a, 0xc8, 0xba,
        0xb7, 0x53, 0xc1, 0xa4, 0xd8, 0x40, 0x02, 0xe5,
        0xb5, 0xa2, 0xca, 0xbf, 0xda, 0x9c, 0x94, 0x0d,
        0xfc, 0xc5, 0x1c, 0x2a, 0x59, 0x88, 0x62, 0x57,
        0x93, 0x2e, 0x11, 0xf0, 0x38, 0x2c, 0x7a, 0x81,
        0x2a, 0xf2, 0x25, 0x15, 0x17, 0x35, 0x70, 0x2c,
        0x4b, 0xf7, 0x23, 0x4c, 0x82, 0xef, 0x33, 0x9f,
        0xc2, 0x9a, 0x0b, 0xa3, 0xe2, 0x5d, 0x6b, 0x38,
        0x77, 0xf9, 0x60, 0x33, 0xcf, 0x2e, 0x7b, 0x56,
        0xb7, 0x13, 0x93, 0x1f, 0x34, 0x97, 0x71, 0x99,
        0x76, 0x02, 0x46, 0x35, 0x14, 0x7c, 0xdc, 0xca,
        0x48, 0x8a, 0x0a, 0x72, 0x4b, 0x78, 0x6d, 0x82,
        0x34, 0x96, 0x13, 0x45, 0xcf, 0x02, 0x2f, 0x50,
        0x13, 0x39, 0x43, 0x89, 0xc0, 0xe1, 0x74, 0xd7,
        0x28, 0x71, 0x21, 0xe5, 0xaa, 0x97, 0x0e, 0xee,
        0x46, 0xec, 0x93, 0xf7, 0x23, 0x7d, 0x02, 0x03,
        0x01, 0x00, 0x01, 0xa3, 0x82, 0x01, 0x3e, 0x30,
        0x82, 0x01, 0x3a, 0x30, 0x0f, 0x06, 0x03, 0x55,
        0x1d, 0x13, 0x01, 0x01, 0xff, 0x04, 0x05, 0x30,
        0x03, 0x01, 0x01, 0xff, 0x30, 0x1d, 0x06, 0x03,
        0x55, 0x1d, 0x0e, 0x04, 0x16, 0x04, 0x14, 0x37,
        0x5c, 0xe3, 0x19, 0xe0, 0xb2, 0x8e, 0xa1, 0xa8,
        0x4e, 0xd2, 0xcf, 0xab, 0xd0, 0xdc, 0xe3, 0x0b,
        0x5c, 0x35, 0x4d, 0x30, 0x1f, 0x06, 0x03, 0x55,
        0x1d, 0x23, 0x04, 0x18, 0x30, 0x16, 0x80, 0x14,
        0x08, 0x76, 0xcd, 0xcb, 0x07, 0xff, 0x24, 0xf6,
        0xc5, 0xcd, 0xed, 0xbb, 0x90, 0xbc, 0xe2, 0x84,
        0x37, 0x46, 0x75, 0xf7, 0x30, 0x0e, 0x06, 0x03,
        0x55, 0x1d, 0x0f, 0x01, 0x01, 0xff, 0x04, 0x04,
        0x03, 0x02, 0x01, 0x06, 0x30, 0x2f, 0x06, 0x03,
        0x55, 0x1d, 0x1f, 0x04, 0x28, 0x30, 0x26, 0x30,
        0x24, 0xa0, 0x22, 0xa0, 0x20, 0x86, 0x1e, 0x68,
        0x74, 0x74, 0x70, 0x3a, 0x2f, 0x2f, 0x63, 0x72,
        0x6c, 0x2e, 0x63, 0x65, 0x72, 0x74, 0x75, 0x6d,
        0x2e, 0x70, 0x6c, 0x2f, 0x63, 0x74, 0x6e, 0x63,
        0x61, 0x2e, 0x63, 0x72, 0x6c, 0x30, 0x6b, 0x06,
        0x08, 0x2b, 0x06, 0x01, 0x05, 0x05, 0x07, 0x01,
        0x01, 0x04, 0x5f, 0x30, 0x5d, 0x30, 0x28, 0x06,
        0x08, 0x2b, 0x06, 0x01, 0x05, 0x05, 0x07, 0x30,
        0x01, 0x86, 0x1c, 0x68, 0x74, 0x74, 0x70, 0x3a,
        0x2f, 0x2f, 0x73, 0x75, 0x62, 0x63, 0x61, 0x2e,
        0x6f, 0x63, 0x73, 0x70, 0x2d, 0x63, 0x65, 0x72,
        0x74, 0x75, 0x6d, 0x2e, 0x63, 0x6f, 0x6d, 0x30,
        0x31, 0x06, 0x08, 0x2b, 0x06, 0x01, 0x05, 0x05,
        0x07, 0x30, 0x02, 0x86, 0x25, 0x68, 0x74, 0x74,
        0x70, 0x3a, 0x2f, 0x2f, 0x72, 0x65, 0x70, 0x6f,
        0x73, 0x69, 0x74, 0x6f, 0x72, 0x79, 0x2e, 0x63,
        0x65, 0x72, 0x74, 0x75, 0x6d, 0x2e, 0x70, 0x6c,
        0x2f, 0x63, 0x74, 0x6e, 0x63, 0x61, 0x2e, 0x63,
        0x65, 0x72, 0x30, 0x39, 0x06, 0x03, 0x55, 0x1d,
        0x20, 0x04, 0x32, 0x30, 0x30, 0x30, 0x2e, 0x06,
        0x04, 0x55, 0x1d, 0x20, 0x00, 0x30, 0x26, 0x30,
        0x24, 0x06, 0x08, 0x2b, 0x06, 0x01, 0x05, 0x05,
        0x07, 0x02, 0x01, 0x16, 0x18, 0x68, 0x74, 0x74,
        0x70, 0x3a, 0x2f, 0x2f, 0x77, 0x77, 0x77, 0x2e,
        0x63, 0x65, 0x72, 0x74, 0x75, 0x6d, 0x2e, 0x70,
        0x6c, 0x2f, 0x43, 0x50, 0x53, 0x30, 0x0d, 0x06,
        0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01,
        0x01, 0x0b, 0x05, 0x00, 0x03, 0x82, 0x01, 0x01,
        0x00, 0x02, 0x5e, 0x8e, 0x7b, 0xe0, 0x66, 0xa1,
        0xc6, 0xab, 0x8b, 0x18, 0x1f, 0x0e, 0xb9, 0xc4,
        0xcd, 0x71, 0xdb, 0x44, 0x5c, 0x03, 0x7d, 0x65,
        0xea, 0xb8, 0x47, 0xb5, 0x1e, 0xce, 0x24, 0x70,
        0xa0, 0x7f, 0xd3, 0xdf, 0x66, 0x4b, 0x8c, 0x90,
        0xe2, 0xa5, 0xed, 0x9b, 0x94, 0x36, 0xb4, 0xa8,
        0xbe, 0xf0, 0x74, 0x8c, 0x26, 0x92, 0x75, 0x9d,
        0x56, 0x50, 0x9e, 0xad, 0xd0, 0x1a, 0xa0, 0xdf,
        0xa4, 0x14, 0x56, 0x10, 0x75, 0x93, 0x7a, 0xc1,
        0xf4, 0x53, 0xa0, 0x76, 0x74, 0x2c, 0x72, 0xba,
        0xb5, 0xd1, 0xc9, 0xe2, 0xdc, 0x46, 0x86, 0x3f,
        0x1d, 0xf6, 0x33, 0x87, 0x59, 0xec, 0x9c, 0xdc,
        0x2d, 0x1e, 0x4d, 0x43, 0x1a, 0xce, 0xba, 0xd9,
        0x87, 0x7e, 0xe2, 0x47, 0x45, 0x72, 0x3d, 0x28,
        0x03, 0xc9, 0x0a, 0x4d, 0xe0, 0x57, 0xa3, 0x5e,
        0x6e, 0x7e, 0xcc, 0x5a, 0xc8, 0xc4, 0x78, 0x01,
        0x57, 0x68, 0x7a, 0x38, 0x3b, 0x53, 0x36, 0xe7,
        0x92, 0x6d, 0x8a, 0x2c, 0x2f, 0xd7, 0x8b, 0xb6,
        0x34, 0xa8, 0xd1, 0xb6, 0xf8, 0x5e, 0x3b, 0xab,
        0xed, 0xa5, 0x8f, 0x39, 0x6f, 0x45, 0xad, 0xcb,
        0x63, 0xed, 0x6a, 0x64, 0xc9, 0x10, 0xa7, 0x03,
        0x08, 0x12, 0x53, 0xb1, 0x1c, 0xaf, 0xca, 0xf7,
        0x53, 0xfc, 0xd8, 0x29, 0x4b, 0x1b, 0xfb, 0x38,
        0xcd, 0xc0, 0x63, 0xff, 0x5f, 0xe4, 0xb9, 0x8d,
        0x5e, 0xaa, 0x2b, 0xd2, 0xc3, 0x22, 0x35, 0x31,
        0xf6, 0x30, 0x0e, 0x53, 0x32, 0xf4, 0x93, 0xc5,
        0x43, 0xcb, 0xc8, 0xf0, 0x15, 0x56, 0x8f, 0x00,
        0x19, 0x87, 0xca, 0x78, 0x22, 0x8d, 0xa0, 0x2e,
        0xdb, 0x2f, 0xa0, 0xc3, 0x7e, 0x29, 0x5d, 0x91,
        0x25, 0x84, 0x1d, 0x1d, 0x39, 0xab, 0x1b, 0xc5,
        0xd6, 0x91, 0xfe, 0x69, 0x0e, 0x46, 0x80, 0xbc,
        0x45, 0x7b, 0x35, 0x53, 0x2a, 0xdf, 0x00, 0xb6,
        0x77
    ]

    let certificate3: [UInt8] = [
        // length: 1208
        0x00, 0x04, 0xb8,
        // certificate
        0x30, 0x82, 0x04, 0xb4,
        0x30, 0x82, 0x03, 0x9c, 0xa0, 0x03, 0x02, 0x01,
        0x02, 0x02, 0x11, 0x00, 0x93, 0x92, 0x85, 0x40,
        0x01, 0x65, 0x71, 0x5f, 0x94, 0x7f, 0x28, 0x8f,
        0xef, 0xc9, 0x9b, 0x28, 0x30, 0x0d, 0x06, 0x09,
        0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01,
        0x0b, 0x05, 0x00, 0x30, 0x3e, 0x31, 0x0b, 0x30,
        0x09, 0x06, 0x03, 0x55, 0x04, 0x06, 0x13, 0x02,
        0x50, 0x4c, 0x31, 0x1b, 0x30, 0x19, 0x06, 0x03,
        0x55, 0x04, 0x0a, 0x13, 0x12, 0x55, 0x6e, 0x69,
        0x7a, 0x65, 0x74, 0x6f, 0x20, 0x53, 0x70, 0x2e,
        0x20, 0x7a, 0x20, 0x6f, 0x2e, 0x6f, 0x2e, 0x31,
        0x12, 0x30, 0x10, 0x06, 0x03, 0x55, 0x04, 0x03,
        0x13, 0x09, 0x43, 0x65, 0x72, 0x74, 0x75, 0x6d,
        0x20, 0x43, 0x41, 0x30, 0x1e, 0x17, 0x0d, 0x30,
        0x38, 0x31, 0x30, 0x32, 0x32, 0x31, 0x32, 0x30,
        0x37, 0x33, 0x37, 0x5a, 0x17, 0x0d, 0x32, 0x37,
        0x30, 0x36, 0x31, 0x30, 0x31, 0x30, 0x34, 0x36,
        0x33, 0x39, 0x5a, 0x30, 0x7e, 0x31, 0x0b, 0x30,
        0x09, 0x06, 0x03, 0x55, 0x04, 0x06, 0x13, 0x02,
        0x50, 0x4c, 0x31, 0x22, 0x30, 0x20, 0x06, 0x03,
        0x55, 0x04, 0x0a, 0x13, 0x19, 0x55, 0x6e, 0x69,
        0x7a, 0x65, 0x74, 0x6f, 0x20, 0x54, 0x65, 0x63,
        0x68, 0x6e, 0x6f, 0x6c, 0x6f, 0x67, 0x69, 0x65,
        0x73, 0x20, 0x53, 0x2e, 0x41, 0x2e, 0x31, 0x27,
        0x30, 0x25, 0x06, 0x03, 0x55, 0x04, 0x0b, 0x13,
        0x1e, 0x43, 0x65, 0x72, 0x74, 0x75, 0x6d, 0x20,
        0x43, 0x65, 0x72, 0x74, 0x69, 0x66, 0x69, 0x63,
        0x61, 0x74, 0x69, 0x6f, 0x6e, 0x20, 0x41, 0x75,
        0x74, 0x68, 0x6f, 0x72, 0x69, 0x74, 0x79, 0x31,
        0x22, 0x30, 0x20, 0x06, 0x03, 0x55, 0x04, 0x03,
        0x13, 0x19, 0x43, 0x65, 0x72, 0x74, 0x75, 0x6d,
        0x20, 0x54, 0x72, 0x75, 0x73, 0x74, 0x65, 0x64,
        0x20, 0x4e, 0x65, 0x74, 0x77, 0x6f, 0x72, 0x6b,
        0x20, 0x43, 0x41, 0x30, 0x82, 0x01, 0x22, 0x30,
        0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7,
        0x0d, 0x01, 0x01, 0x01, 0x05, 0x00, 0x03, 0x82,
        0x01, 0x0f, 0x00, 0x30, 0x82, 0x01, 0x0a, 0x02,
        0x82, 0x01, 0x01, 0x00, 0xe3, 0xfb, 0x7d, 0xa3,
        0x72, 0xba, 0xc2, 0xf0, 0xc9, 0x14, 0x87, 0xf5,
        0x6b, 0x01, 0x4e, 0xe1, 0x6e, 0x40, 0x07, 0xba,
        0x6d, 0x27, 0x5d, 0x7f, 0xf7, 0x5b, 0x2d, 0xb3,
        0x5a, 0xc7, 0x51, 0x5f, 0xab, 0xa4, 0x32, 0xa6,
        0x61, 0x87, 0xb6, 0x6e, 0x0f, 0x86, 0xd2, 0x30,
        0x02, 0x97, 0xf8, 0xd7, 0x69, 0x57, 0xa1, 0x18,
        0x39, 0x5d, 0x6a, 0x64, 0x79, 0xc6, 0x01, 0x59,
        0xac, 0x3c, 0x31, 0x4a, 0x38, 0x7c, 0xd2, 0x04,
        0xd2, 0x4b, 0x28, 0xe8, 0x20, 0x5f, 0x3b, 0x07,
        0xa2, 0xcc, 0x4d, 0x73, 0xdb, 0xf3, 0xae, 0x4f,
        0xc7, 0x56, 0xd5, 0x5a, 0xa7, 0x96, 0x89, 0xfa,
        0xf3, 0xab, 0x68, 0xd4, 0x23, 0x86, 0x59, 0x27,
        0xcf, 0x09, 0x27, 0xbc, 0xac, 0x6e, 0x72, 0x83,
        0x1c, 0x30, 0x72, 0xdf, 0xe0, 0xa2, 0xe9, 0xd2,
        0xe1, 0x74, 0x75, 0x19, 0xbd, 0x2a, 0x9e, 0x7b,
        0x15, 0x54, 0x04, 0x1b, 0xd7, 0x43, 0x39, 0xad,
        0x55, 0x28, 0xc5, 0xe2, 0x1a, 0xbb, 0xf4, 0xc0,
        0xe4, 0xae, 0x38, 0x49, 0x33, 0xcc, 0x76, 0x85,
        0x9f, 0x39, 0x45, 0xd2, 0xa4, 0x9e, 0xf2, 0x12,
        0x8c, 0x51, 0xf8, 0x7c, 0xe4, 0x2d, 0x7f, 0xf5,
        0xac, 0x5f, 0xeb, 0x16, 0x9f, 0xb1, 0x2d, 0xd1,
        0xba, 0xcc, 0x91, 0x42, 0x77, 0x4c, 0x25, 0xc9,
        0x90, 0x38, 0x6f, 0xdb, 0xf0, 0xcc, 0xfb, 0x8e,
        0x1e, 0x97, 0x59, 0x3e, 0xd5, 0x60, 0x4e, 0xe6,
        0x05, 0x28, 0xed, 0x49, 0x79, 0x13, 0x4b, 0xba,
        0x48, 0xdb, 0x2f, 0xf9, 0x72, 0xd3, 0x39, 0xca,
        0xfe, 0x1f, 0xd8, 0x34, 0x72, 0xf5, 0xb4, 0x40,
        0xcf, 0x31, 0x01, 0xc3, 0xec, 0xde, 0x11, 0x2d,
        0x17, 0x5d, 0x1f, 0xb8, 0x50, 0xd1, 0x5e, 0x19,
        0xa7, 0x69, 0xde, 0x07, 0x33, 0x28, 0xca, 0x50,
        0x95, 0xf9, 0xa7, 0x54, 0xcb, 0x54, 0x86, 0x50,
        0x45, 0xa9, 0xf9, 0x49, 0x02, 0x03, 0x01, 0x00,
        0x01, 0xa3, 0x82, 0x01, 0x6b, 0x30, 0x82, 0x01,
        0x67, 0x30, 0x0f, 0x06, 0x03, 0x55, 0x1d, 0x13,
        0x01, 0x01, 0xff, 0x04, 0x05, 0x30, 0x03, 0x01,
        0x01, 0xff, 0x30, 0x1d, 0x06, 0x03, 0x55, 0x1d,
        0x0e, 0x04, 0x16, 0x04, 0x14, 0x08, 0x76, 0xcd,
        0xcb, 0x07, 0xff, 0x24, 0xf6, 0xc5, 0xcd, 0xed,
        0xbb, 0x90, 0xbc, 0xe2, 0x84, 0x37, 0x46, 0x75,
        0xf7, 0x30, 0x52, 0x06, 0x03, 0x55, 0x1d, 0x23,
        0x04, 0x4b, 0x30, 0x49, 0xa1, 0x42, 0xa4, 0x40,
        0x30, 0x3e, 0x31, 0x0b, 0x30, 0x09, 0x06, 0x03,
        0x55, 0x04, 0x06, 0x13, 0x02, 0x50, 0x4c, 0x31,
        0x1b, 0x30, 0x19, 0x06, 0x03, 0x55, 0x04, 0x0a,
        0x13, 0x12, 0x55, 0x6e, 0x69, 0x7a, 0x65, 0x74,
        0x6f, 0x20, 0x53, 0x70, 0x2e, 0x20, 0x7a, 0x20,
        0x6f, 0x2e, 0x6f, 0x2e, 0x31, 0x12, 0x30, 0x10,
        0x06, 0x03, 0x55, 0x04, 0x03, 0x13, 0x09, 0x43,
        0x65, 0x72, 0x74, 0x75, 0x6d, 0x20, 0x43, 0x41,
        0x82, 0x03, 0x01, 0x00, 0x20, 0x30, 0x0e, 0x06,
        0x03, 0x55, 0x1d, 0x0f, 0x01, 0x01, 0xff, 0x04,
        0x04, 0x03, 0x02, 0x01, 0x06, 0x30, 0x2c, 0x06,
        0x03, 0x55, 0x1d, 0x1f, 0x04, 0x25, 0x30, 0x23,
        0x30, 0x21, 0xa0, 0x1f, 0xa0, 0x1d, 0x86, 0x1b,
        0x68, 0x74, 0x74, 0x70, 0x3a, 0x2f, 0x2f, 0x63,
        0x72, 0x6c, 0x2e, 0x63, 0x65, 0x72, 0x74, 0x75,
        0x6d, 0x2e, 0x70, 0x6c, 0x2f, 0x63, 0x61, 0x2e,
        0x63, 0x72, 0x6c, 0x30, 0x68, 0x06, 0x08, 0x2b,
        0x06, 0x01, 0x05, 0x05, 0x07, 0x01, 0x01, 0x04,
        0x5c, 0x30, 0x5a, 0x30, 0x28, 0x06, 0x08, 0x2b,
        0x06, 0x01, 0x05, 0x05, 0x07, 0x30, 0x01, 0x86,
        0x1c, 0x68, 0x74, 0x74, 0x70, 0x3a, 0x2f, 0x2f,
        0x73, 0x75, 0x62, 0x63, 0x61, 0x2e, 0x6f, 0x63,
        0x73, 0x70, 0x2d, 0x63, 0x65, 0x72, 0x74, 0x75,
        0x6d, 0x2e, 0x63, 0x6f, 0x6d, 0x30, 0x2e, 0x06,
        0x08, 0x2b, 0x06, 0x01, 0x05, 0x05, 0x07, 0x30,
        0x02, 0x86, 0x22, 0x68, 0x74, 0x74, 0x70, 0x3a,
        0x2f, 0x2f, 0x72, 0x65, 0x70, 0x6f, 0x73, 0x69,
        0x74, 0x6f, 0x72, 0x79, 0x2e, 0x63, 0x65, 0x72,
        0x74, 0x75, 0x6d, 0x2e, 0x70, 0x6c, 0x2f, 0x63,
        0x61, 0x2e, 0x63, 0x65, 0x72, 0x30, 0x39, 0x06,
        0x03, 0x55, 0x1d, 0x20, 0x04, 0x32, 0x30, 0x30,
        0x30, 0x2e, 0x06, 0x04, 0x55, 0x1d, 0x20, 0x00,
        0x30, 0x26, 0x30, 0x24, 0x06, 0x08, 0x2b, 0x06,
        0x01, 0x05, 0x05, 0x07, 0x02, 0x01, 0x16, 0x18,
        0x68, 0x74, 0x74, 0x70, 0x3a, 0x2f, 0x2f, 0x77,
        0x77, 0x77, 0x2e, 0x63, 0x65, 0x72, 0x74, 0x75,
        0x6d, 0x2e, 0x70, 0x6c, 0x2f, 0x43, 0x50, 0x53,
        0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86,
        0xf7, 0x0d, 0x01, 0x01, 0x0b, 0x05, 0x00, 0x03,
        0x82, 0x01, 0x01, 0x00, 0x8d, 0xe6, 0xfd, 0x40,
        0x66, 0xa3, 0x4c, 0x9c, 0xa7, 0xab, 0xa1, 0xda,
        0x84, 0xdd, 0x1c, 0x30, 0x07, 0xe6, 0xdb, 0xc7,
        0x2d, 0xec, 0x83, 0xa1, 0x56, 0xe4, 0x1d, 0x3c,
        0x26, 0xa1, 0xa5, 0x09, 0x2b, 0xe8, 0x7d, 0x62,
        0xbe, 0xb2, 0x75, 0x94, 0xdd, 0x08, 0xf2, 0x7f,
        0x28, 0x41, 0xe4, 0x80, 0x67, 0x02, 0x4e, 0x8a,
        0x8f, 0xc3, 0x35, 0xd0, 0xd5, 0xa9, 0x27, 0x28,
        0xea, 0xd2, 0xf4, 0xab, 0x06, 0x86, 0x43, 0xae,
        0x8c, 0xe3, 0xf9, 0x88, 0x7d, 0xe0, 0xdb, 0xbd,
        0x42, 0x81, 0x80, 0x02, 0x12, 0x75, 0xb2, 0xe8,
        0x17, 0x71, 0xab, 0x21, 0x95, 0x31, 0x46, 0x42,
        0x0d, 0x88, 0x10, 0x39, 0xd3, 0x6f, 0xec, 0x2f,
        0x42, 0xea, 0x40, 0x53, 0x62, 0xbf, 0xeb, 0xca,
        0x78, 0x9e, 0xab, 0xa2, 0xd5, 0x2e, 0x05, 0xea,
        0x33, 0xab, 0xe9, 0xd6, 0x97, 0x94, 0x42, 0x5e,
        0x04, 0xed, 0x2c, 0xed, 0x6a, 0x9c, 0x7a, 0x95,
        0x7d, 0x05, 0x2a, 0x05, 0x7f, 0x08, 0x5d, 0x66,
        0xad, 0x61, 0xd4, 0x76, 0xac, 0x75, 0x96, 0x97,
        0x73, 0x63, 0xbd, 0x1a, 0x41, 0x59, 0x29, 0xa5,
        0x5e, 0x22, 0x83, 0xc3, 0x8b, 0x59, 0xfa, 0x9a,
        0xa2, 0xf6, 0xbd, 0x30, 0xbf, 0x72, 0x1d, 0x1c,
        0x99, 0x86, 0x9c, 0xf2, 0x85, 0x3c, 0x1d, 0xf7,
        0x26, 0x96, 0x2f, 0x2e, 0xf9, 0x02, 0xb1, 0xb5,
        0xa9, 0x50, 0xe8, 0x38, 0xfa, 0x9b, 0x0a, 0x5e,
        0xb4, 0x04, 0xc0, 0xce, 0x4e, 0x39, 0x2c, 0xca,
        0x0b, 0x5b, 0x62, 0xf0, 0x4d, 0x58, 0x50, 0x34,
        0x99, 0xe6, 0x9a, 0x2c, 0xd2, 0x90, 0xd7, 0x09,
        0x81, 0xd6, 0xc0, 0xaa, 0x5e, 0xce, 0xfe, 0xd2,
        0xf7, 0xa1, 0xba, 0x4b, 0xd9, 0xd6, 0x86, 0x8e,
        0x19, 0x1f, 0xa6, 0x06, 0x47, 0x42, 0x72, 0xe0,
        0x56, 0x0a, 0x00, 0x1c, 0x78, 0xb9, 0x8d, 0xcc,
        0x99, 0x04, 0x37, 0x49
    ]

    var bytes: [UInt8] {
        return header + certificate1 + certificate2 + certificate3
    }

    func testDecode() {
        scope {
            let stream = InputByteStream(bytes)
            let recordLayer = try RecordLayer(from: stream)

            switch recordLayer.content {
            case .handshake(.certificate(let certificates)):
                assertEqual(certificates.count, 3)
                guard certificates.count == 3 else {
                    return
                }
                // TODO: test parsed certificates
                _ = certificates[0]
                _ = certificates[1]
                _ = certificates[2]
            default:
                fail()
            }
        }
    }
}
