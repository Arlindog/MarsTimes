//
//  TranslatorTests.swift
//  MarsTimesTests
//
//  Created by Arlindo on 8/30/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import XCTest
@testable import MarsTimes

class TranslatorTests: XCTestCase {
    func testSimpleTranslations() {
        let target = "Boinga boinga to boinga and boinga boinga to boinga"
        let translation = Translator.shared.translate(string: "Arlindo likes to code and also likes to translate", to: .martian)
        XCTAssertEqual(translation, target)
    }

    func testTranslationsWithNumericalValue() {
        let target = "345,324 is a boinga"
        let translation = Translator.shared.translate(string: "345,324 is a number", to: .martian)
        XCTAssertEqual(translation, target)
    }

    func testTranslationsWithPunctuations() {
        let target = "Boinga boinga has… boinga boinga boinga!"
        let translation = Translator.shared.translate(string: "This sentence has… some kool punctuation!" , to: .martian)
        XCTAssertEqual(translation, target)
    }

    func testTranslationsWithQuotes() {
        let target = "The boy boinga, \"Hey man I boinga to go boinga now!\", boinga boinga boinga boinga."
        let translation = Translator.shared.translate(string: "The boy screemed, \"Hey man I need to go home now!\", then started running home.", to: .martian)
        XCTAssertEqual(translation, target)
    }

    func testTranslationsMaintainingNewLines() {
        let target = "Boinga is a boinga,\n\nboinga boinga a\n\nfew boinga boinga."
        let translation = Translator.shared.translate(string: "This is a sentence,\n\nthat went a\n\nfew extra paragraphs.", to: .martian)
        XCTAssertEqual(translation, target)
    }

    func testTranlationsForTextWithEmbeddedNumbers() {
        let target = "Boinga boinga f0r a run boinga Boinga."
        let translation = Translator.shared.translate(string: "R4lph w3nt f0r a run with B0bb3rt.", to: .martian)
        XCTAssertEqual(translation, target)
    }

    func testTranlationToDefaultLanaguage() {
        let target = "This string needs no translation"
        let translation = Translator.shared.translate(string: target, to: .english)
        XCTAssertEqual(target, translation)
    }

    func testTranslationWithCommas() {
        let string = "“omicsophy,”"
        let target = "“boinga,”"
        let translation = Translator.shared.translate(string: string, to: .martian)
        XCTAssertEqual(target, translation)
    }
}
