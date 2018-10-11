//
//  SuppertClassesTest.swift
//  FlatPageControlTests
//
//  Created by Александр Чаусов on 11.10.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

import XCTest
@testable import FlatPageControl

class SupportClassesTest: XCTestCase {

    func testPageIndicator_1() {
        let pageIndicator = FlatPageIndicator(frame: .zero, tintColor: .red)
        for subview in pageIndicator.subviews {
            XCTAssertEqual(subview.backgroundColor, .red)
        }
        pageIndicator.changeIndicatorColor(.green)
        for subview in pageIndicator.subviews {
            XCTAssertEqual(subview.backgroundColor, .green)
        }
    }

    func testPageIndicator_2() {
        let pageIndicator = FlatPageIndicator(frame: .zero)
        pageIndicator.changeIndicatorColor(.purple)
        for subview in pageIndicator.subviews {
            XCTAssertEqual(subview.backgroundColor, .purple)
        }
    }

    func testViewsPool() {
        var pool = ViewsPool()
        XCTAssertNil(pool.view())
        pool.push(UIView())
        XCTAssertNotNil(pool.view())
    }

}
