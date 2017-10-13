//
//  WodsPresenterTests.swift
//  WODmvpTests
//
//  Created by Will Ellis on 10/10/17.
//  Copyright © 2017 Will Ellis Inc. All rights reserved.
//

import XCTest
@testable import WODmvp

class MockWodsView: WodsView {
    var calledRenderViewModel = false
    func render(_ viewModel: WodsViewModel) {
        calledRenderViewModel = true
    }
}

class MockWodsModelProvider: WodsModelProviderType {
    var subscriber: WodsModelSubscriber?

    var calledLoadModel = false
    func loadModel() {
        calledLoadModel = true
    }
}

class WodsPresenterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func makeMockedWodsPresenter() -> (WodsPresenter, MockWodsView, MockWodsModelProvider) {
        let mockWodsView = MockWodsView()
        let mockWodsModelProvider = MockWodsModelProvider()
        let wodsPresenter = WodsPresenter(mockWodsModelProvider)
        return (wodsPresenter, mockWodsView, mockWodsModelProvider)
    }
    
    func testSetViewAlsoSetsWodsModelProviderSubscriber() {
        let (wodsPresenter, mockWodsView, mockWodsModelProvider) = makeMockedWodsPresenter()

        wodsPresenter.view = mockWodsView
        XCTAssertNotNil(mockWodsModelProvider.subscriber)
        XCTAssert(mockWodsModelProvider.subscriber! === wodsPresenter)

        wodsPresenter.view = nil
        XCTAssertNil(mockWodsModelProvider.subscriber)
    }

    func testUpdateWodsModel() {
        let (wodsPresenter, mockWodsView, mockWodsModelProvider) = makeMockedWodsPresenter()
        wodsPresenter.view = mockWodsView

        wodsPresenter.update(WodsModel())
        XCTAssert(mockWodsView.calledRenderViewModel)
        XCTAssert(mockWodsModelProvider.calledLoadModel)
    }

    func testPresentWodDetails() {
        // TODO: WTE
    }
}
