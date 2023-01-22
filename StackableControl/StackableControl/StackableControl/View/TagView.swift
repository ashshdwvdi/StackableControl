//
//  TagView.swift
//  StackableControl
//
//  Created by Ashish Dwivedi on 22/01/23.
//

import SwiftUI

struct TagView: View {
    @ObservedObject var tag: Tag
    
    var body: some View {
        Button {
            tag.isSelected.toggle()
        } label: {
            Text(tag.name)
                .lineLimit(1)
                .padding(12)
                .font(.callout)
                .foregroundColor(Color.black)
        }
        .background(
            Capsule()
                .fill(tag.isSelected ? Color.gray.opacity(0.2) : Color.white)
        )
        .overlay(
            Capsule(style: .circular)
                .strokeBorder(Color.black)
        )
    }
}
