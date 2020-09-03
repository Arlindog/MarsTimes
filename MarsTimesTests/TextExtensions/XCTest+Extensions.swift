//
//  XCTest+Extensions.swift
//  MarsTimesTests
//
//  Created by Arlindo on 9/4/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import XCTest

public func XCTAssertTrue(_ expression: @autoclosure () throws -> Bool?, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {
    XCTAssertTrue(try expression() ?? false, message(), file: file, line: line)
}

public func XCTAssertFalse(_ expression: @autoclosure () throws -> Bool?, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {
    XCTAssertFalse(try expression() ?? false, message(), file: file, line: line)
}
