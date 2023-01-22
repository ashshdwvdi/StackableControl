//
//  PagesDriver.swift
//  StackableControl
//
//  Created by Ashish Dwivedi on 22/01/23.
//

import SwiftUI

protocol PageSelecting {
    func select(pageId: UUID)
}

public final class PagesDriver {
    private let minPages: Int
    private let maxPages: Int
    
    private(set) var pages: [StackPageView] = []
    private(set) var selectedPage: StackPageView?
    
    public init(minimumPages: Int = 2, maximumPages: Int = 4) {
        self.minPages = minimumPages
        self.maxPages = maximumPages
        self.pages.reserveCapacity(maximumPages)
    }
    
    public func add(page: StackPageView) {
        guard pages.count < self.maxPages else { return }
        self.pages.append(page)
    }
    
    public func next() {
        guard pages.count <= self.maxPages else { return }
        guard pages.count >= self.minPages else { return }
        guard let selectedPage = self.selectedPage else {
            self.selectedPage = pages.first
            self.selectedPage?.asset.isExpanded = true
            return
        }
        
        for index in stride(from: 0, to: pages.count, by: 1) {
            if pages[safe: index]?.asset.id == selectedPage.asset.id {
                trySelectingPage(after: index)
            } else {
                selectedPage.asset.isExpanded = false
            }
        }
    }
    
    public func select(pageId: UUID) {
        for index in stride(from: 0, to: pages.count, by: 1) {
            pages[safe: index]?.asset.isExpanded = pages[safe: index]?.asset.id == pageId
            if pages[safe: index]?.asset.id == pageId {
                selectedPage = pages[safe: index]
            }
        }
    }
    
    private func trySelectingPage(after index: Int) {
        selectedPage = pages[safe: index + 1]
        selectedPage?.asset.isExpanded = true
    }
}
