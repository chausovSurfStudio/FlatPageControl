//
//  FlatPageControlTests.swift
//  FlatPageControlTests
//
//  Created by Александр Чаусов on 01.10.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

import XCTest
@testable import FlatPageControl

class FlatPageControlTests: XCTestCase {

    func testFlatPageControl_1() {
        let pageControl = FlatPageControl(frame: .zero)
        XCTAssertNotNil(pageControl.view)
    }

    func testFlatPageControl_2() {
        let pageControl = FlatPageControl(frame: .zero)
        pageControl.numberOfPages = 10
        pageControl.setCurrentPage(5, animated: false)
        XCTAssertEqual(pageControl.currentPage, 5)
        pageControl.setCurrentPage(15, animated: false)
        XCTAssertEqual(pageControl.currentPage, 5)
    }

    func testFlatPageControl_3() {
        let pageControl = FlatPageControl(frame: .zero)
        pageControl.numberOfPages = 10
        pageControl.setCurrentPage(5, animated: true)
        XCTAssertEqual(pageControl.currentPage, 5)
        pageControl.setCurrentPage(15, animated: true)
        XCTAssertEqual(pageControl.currentPage, 5)
    }

    func testFlatPageControl_4() {
        let pageControl = FlatPageControl(frame: .zero)
        pageControl.numberOfPages = 10
        pageControl.setCurrentPage(5, animated: true)
        XCTAssertEqual(pageControl.currentPage, 5)
        pageControl.setCurrentPage(6, animated: true)
        XCTAssertEqual(pageControl.currentPage, 6)
    }

    func testFlatPageControl_5() {
        let pageControl = FlatPageControl(frame: .zero)
        pageControl.hidesForSinglePage = true
        pageControl.numberOfPages = 1
        XCTAssertEqual(pageControl.containerView.isHidden, true)
    }

    func testFlatPageControl_6() {
        let pageControl = FlatPageControl(frame: .zero)
        pageControl.numberOfPages = 20
        pageControl.maxPagesNumber = 10
        pageControl.setCurrentPage(5, animated: true)
        XCTAssertEqual(pageControl.currentPage, 5)
        pageControl.setCurrentPage(6, animated: true)
        XCTAssertEqual(pageControl.currentPage, 6)
        pageControl.setCurrentPage(5, animated: true)
        XCTAssertEqual(pageControl.currentPage, 5)
    }

    func testFlatPageControl_7() {
        let pageControl = FlatPageControl(frame: .zero)
        pageControl.numberOfPages = 20
        pageControl.maxPagesNumber = 10
        pageControl.setCurrentPage(19, animated: true)
        XCTAssertEqual(pageControl.currentPage, 19)
        pageControl.setCurrentPage(0, animated: true)
        XCTAssertEqual(pageControl.currentPage, 0)
        pageControl.setCurrentPage(1, animated: true)
        XCTAssertEqual(pageControl.currentPage, 1)
    }

    func testFlatPageControl_8() {
        let pageControl = FlatPageControl(frame: .zero)
        pageControl.numberOfPages = 20
        pageControl.maxPagesNumber = 10
        pageControl.setCurrentPage(0, animated: true)
        XCTAssertEqual(pageControl.currentPage, 0)
        pageControl.setCurrentPage(19, animated: true)
        XCTAssertEqual(pageControl.currentPage, 19)
        pageControl.setCurrentPage(19, animated: true)
        XCTAssertEqual(pageControl.currentPage, 19)
    }

}
