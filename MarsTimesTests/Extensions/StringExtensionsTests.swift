//
//  StringExtensionsTests.swift
//  MarsTimesTests
//
//  Created by Arlindo on 8/31/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import XCTest
@testable import MarsTimes

class StringExtensionsTests: XCTestCase {

    func testRemovingPunctions() {
        XCTAssertEqual("\"Hey!!!!!!!!\"".excludingPunctuations, "Hey")
    }

    func testProceedingPunctations() {
        let punctuations = "\"Hey!!!!!!!!\"".proceedingPunctuations
        XCTAssertEqual(String(punctuations ?? []), "\"")
    }

    func testTrailingPunctations() {
        let punctuations = "\"Hey!!!!!!!!\"".trailingPunctuations
        XCTAssertEqual(String(punctuations ?? []), "!!!!!!!!\"")
    }

    func testTrailingPunctationsWithAbbreviation() {
        let punctuations = "hey Dr D.,".trailingPunctuations
        XCTAssertEqual(String(punctuations ?? []), ",")
    }
}
