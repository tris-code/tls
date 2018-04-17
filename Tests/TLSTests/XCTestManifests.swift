import XCTest

extension AlertTests {
    static let __allTests = [
        ("testDecode", testDecode),
        ("testEncode", testEncode),
    ]
}

extension ClientHelloTests {
    static let __allTests = [
        ("testDecode", testDecode),
        ("testEncode", testEncode),
    ]
}

extension ExtensionECPointFormatsTests {
    static let __allTests = [
        ("testDecode", testDecode),
        ("testDecodeExtension", testDecodeExtension),
        ("testEncode", testEncode),
        ("testEncodeExtension", testEncodeExtension),
    ]
}

extension ExtensionHeartbeatTests {
    static let __allTests = [
        ("testDecode", testDecode),
        ("testDecodeExtension", testDecodeExtension),
        ("testEncode", testEncode),
        ("testEncodeExtension", testEncodeExtension),
    ]
}

extension ExtensionRenegotiationInfoTests {
    static let __allTests = [
        ("testDecode", testDecode),
        ("testDecodeExtension", testDecodeExtension),
        ("testEncode", testEncode),
        ("testEncodeExtension", testEncodeExtension),
    ]
}

extension ExtensionServerNameTests {
    static let __allTests = [
        ("testDecode", testDecode),
        ("testDecodeExtension", testDecodeExtension),
        ("testDecodeName", testDecodeName),
        ("testEncode", testEncode),
        ("testEncodeExtension", testEncodeExtension),
        ("testEncodeName", testEncodeName),
    ]
}

extension ExtensionSessionTicketTests {
    static let __allTests = [
        ("testDecodeEmpty", testDecodeEmpty),
        ("testDecodeEmptyRandom", testDecodeEmptyRandom),
        ("testEncodeEmpty", testEncodeEmpty),
        ("testEncodeEmptyRandom", testEncodeEmptyRandom),
    ]
}

extension ExtensionSignatureAlgorithmsTests {
    static let __allTests = [
        ("testDecode", testDecode),
        ("testDecodeExtension", testDecodeExtension),
        ("testEncode", testEncode),
        ("testEncodeExtension", testEncodeExtension),
    ]
}

extension ExtensionStatusRequestTests {
    static let __allTests = [
        ("testDecode", testDecode),
        ("testDecodeExtension", testDecodeExtension),
        ("testEncode", testEncode),
        ("testEncodeExtension", testEncodeExtension),
    ]
}

extension ExtensionSupportedGroupsTests {
    static let __allTests = [
        ("testDecode", testDecode),
        ("testDecodeExtension", testDecodeExtension),
        ("testEncode", testEncode),
        ("testEncodeExtension", testEncodeExtension),
    ]
}

extension HandshakeTests {
    static let __allTests = [
        ("testDecode", testDecode),
        ("testEncode", testEncode),
    ]
}

extension RandomTests {
    static let __allTests = [
        ("testRandom", testRandom),
        ("testRandomBytes", testRandomBytes),
    ]
}

extension RecordLayerTests {
    static let __allTests = [
        ("testDecode", testDecode),
        ("testEncode", testEncode),
    ]
}

extension ServerHelloTests {
    static let __allTests = [
        ("testDecode", testDecode),
        ("testEncode", testEncode),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AlertTests.__allTests),
        testCase(ClientHelloTests.__allTests),
        testCase(ExtensionECPointFormatsTests.__allTests),
        testCase(ExtensionHeartbeatTests.__allTests),
        testCase(ExtensionRenegotiationInfoTests.__allTests),
        testCase(ExtensionServerNameTests.__allTests),
        testCase(ExtensionSessionTicketTests.__allTests),
        testCase(ExtensionSignatureAlgorithmsTests.__allTests),
        testCase(ExtensionStatusRequestTests.__allTests),
        testCase(ExtensionSupportedGroupsTests.__allTests),
        testCase(HandshakeTests.__allTests),
        testCase(RandomTests.__allTests),
        testCase(RecordLayerTests.__allTests),
        testCase(ServerHelloTests.__allTests),
    ]
}
#endif
