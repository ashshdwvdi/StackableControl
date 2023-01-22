//
//  StackableControlTests.swift
//  StackableControlTests
//
//  Created by Ashish Dwivedi on 22/01/23.
//

import SwiftUI
import XCTest
@testable import StackableControl

class StackableControlTests: XCTestCase {
    func test_next_returnsSelectedPageNil_whenNoPagesInDriver() {
        let sut = PagesDriver(minimumPages: 1, maximumPages: 2)
        
        sut.next()
        
        XCTAssertNil(sut.selectedPage)
        XCTAssertTrue(sut.pages.isEmpty)
    }
    
    func test_add_willNotSurpass_maxPagesCount() {
        let sut = PagesDriver(minimumPages: 1, maximumPages: 2)
        
        sut.add(page: anyPage())
        sut.add(page: anyPage())
        sut.add(page: anyPage())
        
        XCTAssertEqual(sut.pages.count, 2)
    }
    
    func test_next_willSelectPage_whenMinimumNumberOfPagesConstraintIsMet() {
        let sut = PagesDriver(minimumPages: 2, maximumPages: 3)
        
        sut.add(page: anyPage())
        sut.add(page: anyPage())
        sut.next()
        
        XCTAssertNotNil(sut.selectedPage)
    }
    
    func test_next_willNotSelectPage_whenMinimumNumberOfPagesConstraintIsNotMet() {
        let sut = PagesDriver(minimumPages: 2, maximumPages: 3)
        
        sut.add(page: anyPage())
        sut.next()
        
        XCTAssertNil(sut.selectedPage)
    }
    
    func test_next_makesSelection_whenConstraintsAreValid_AndByDefaultSelectsFirstPage() {
        let sut = PagesDriver(minimumPages: 1, maximumPages: 2)
        
        sut.add(page: anyPage())
        sut.add(page: anyPage())
        sut.next()
        
        XCTAssertEqual(sut.selectedPage?.asset.id, sut.pages.first?.asset.id)
    }
    
    func test_next_makesSelection_onCallingNextTwice() {
        let sut = PagesDriver(minimumPages: 1, maximumPages: 2)
        
        sut.add(page: anyPage())
        sut.add(page: anyPage())
        sut.next()
        sut.next()
        
        XCTAssertEqual(sut.selectedPage?.asset.id, sut.pages.last?.asset.id)
    }
    
    func test_next_doesNotMakesSelection_whenPagesAreLessThanMinimumBounds() {
        let sut = PagesDriver(minimumPages: 1, maximumPages: 2)
        
        sut.next()
        
        XCTAssertNil(sut.selectedPage)
    }
    
    func test_next_doesNotMakesSelection_whenPagesAreMoreThanMaximumBounds() {
        let sut = PagesDriver(minimumPages: 1, maximumPages: 2)
        let outOfBoundPage = anyPage()
        
        sut.add(page: anyPage())
        sut.add(page: anyPage())
        sut.add(page: outOfBoundPage)
        sut.next()
        
        XCTAssertNotEqual(sut.selectedPage?.asset.id, outOfBoundPage.asset.id)
    }
    
    // MARK: - Helpers
    
    private func anyPage() -> StackPageView {
        StackPageView(asset: Asset(expandedView: nil, collapsedView: nil, buttonText: "a text"))
    }
}
