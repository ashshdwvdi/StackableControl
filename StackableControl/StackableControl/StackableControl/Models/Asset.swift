//
//  Models.swift
//  StackableControl
//
//  Created by Ashish Dwivedi on 22/01/23.
//

import SwiftUI

public class Asset: ObservableObject {
    let id = UUID()
    let ctaText: String
    @Published var expanded: AnyView?
    @Published var collapsed: AnyView?
    @Published var isExpanded: Bool = false
    
    init(
        expandedView: AnyView?,
        collapsedView: AnyView?,
        buttonText: String
    ) {
        self.expanded = expandedView
        self.collapsed = collapsedView
        self.ctaText = buttonText
    }
}
