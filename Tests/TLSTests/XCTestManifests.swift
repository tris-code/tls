import XCTest

extension AlertTests {
    static let __allTests = [
        ("testAlert", testAlert),
    ]
}

extension ClientHelloTests {
    static let __allTests = [
        ("testClientHello", testClientHello),
    ]
}

extension ExtensionECPointFormatsTests {
    static let __allTests = [
        ("testExtensionECPointFormats", testExtensionECPointFormats),
        ("testExtensionECPointFormatsType", testExtensionECPointFormatsType),
    ]
}

extension ExtensionHeartbeatTests {
    static let __allTests = [
        ("testExtensionHeartbeat", testExtensionHeartbeat),
        ("testExtensionHeartbeatType", testExtensionHeartbeatType),
    ]
}

extension ExtensionRenegotiationInfoTests {
    static let __allTests = [
        ("testExtensionRenegotiationInfo", testExtensionRenegotiationInfo),
        ("testExtensionRenegotiationInfoType", testExtensionRenegotiationInfoType),
    ]
}

extension ExtensionServerNameTests {
    static let __allTests = [
        ("testExtensionServerName", testExtensionServerName),
        ("testExtensionServerNameName", testExtensionServerNameName),
        ("testExtensionServerNameType", testExtensionServerNameType),
    ]
}

extension ExtensionSessionTicketTests {
    static let __allTests = [
        ("testExtensionSessionTicketEmpty", testExtensionSessionTicketEmpty),
        ("testExtensionSessionTicketEmptyRandom", testExtensionSessionTicketEmptyRandom),
    ]
}

extension ExtensionSignatureAlgorithmsTests {
    static let __allTests = [
        ("testExtensionSignatureAlgorithms", testExtensionSignatureAlgorithms),
        ("testExtensionSignatureAlgorithmsType", testExtensionSignatureAlgorithmsType),
    ]
}

extension ExtensionStatusRequestTests {
    static let __allTests = [
        ("testExtensionStatusRequest", testExtensionStatusRequest),
        ("testExtensionStatusRequestType", testExtensionStatusRequestType),
    ]
}

extension ExtensionSupportedGroupsTests {
    static let __allTests = [
        ("testExtensionSupportedGroups", testExtensionSupportedGroups),
        ("testExtensionSupportedGroupsType", testExtensionSupportedGroupsType),
    ]
}

extension HandshakeTests {
    static let __allTests = [
        ("testHandshake", testHandshake),
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
        ("testRecordLayer", testRecordLayer),
    ]
}

extension ServerHelloTests {
    static let __allTests = [
        ("testServerHello", testServerHello),
    ]
}

extension UInt24Tests {
    static let __allTests = [
        ("testBytesSwapped", testBytesSwapped),
        ("testDescription", testDescription),
        ("testUInt24", testUInt24),
        ("testUInt24Max", testUInt24Max),
        ("testUInt24Overflow", testUInt24Overflow),
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
        testCase(UInt24Tests.__allTests),
    ]
}
#endif
