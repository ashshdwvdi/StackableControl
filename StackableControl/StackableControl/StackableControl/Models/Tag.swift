//
//  Tag.swift
//  StackableControl
//
//  Created by Ashish Dwivedi on 22/01/23.
//

import Foundation

class Tag: ObservableObject {
    let name: String
    @Published var isSelected: Bool
    
    init(name: String, isSelected: Bool) {
        self.name = name
        self.isSelected = isSelected
    }
}
