//
//  ViewModel.swift
//  StackableControl
//
//  Created by Ashish Dwivedi on 22/01/23.
//

import Combine
import SwiftUI

class ViewModel: ObservableObject {
    private static let positiveFeedback = [
        "Easy to connect",
        "Unit tests",
        "Proper syntax",
        "Architecture",
        "Idea",
        "Change",
        "Comments"
    ]
    private static let negativeFeedback = [
        "oh typos",
        "Too confusing",
        "Design is off",
        "Colours",
        "Something else",
        "Wrong",
        "Advice"
    ]
    
    @Published var isLiked = false
    @Published var isDisliked = false
    @Published var tags: [[Tag]] = ViewModel.tags(isPositive: true)
    @Published var additionalFeedback: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $isLiked
            .combineLatest($isDisliked)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] liked, disliked in
                self?.updateInputs(isPositive: liked)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Helpers
    
    private func updateInputs(isPositive: Bool) {
        self.tags = Self.tags(isPositive: isPositive)
        self.additionalFeedback = ""
    }
    
    private static func tags(isPositive: Bool) -> [[Tag]] {
        let result = isPositive ? Self.positiveFeedback : Self.negativeFeedback
        let mappedTags = result.map { Tag(name: $0, isSelected: false) }
        return mappedTags.chunked(into: 2)
    }
}
