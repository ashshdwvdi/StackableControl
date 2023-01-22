//
//  Chips.swift
//  StackableControl
//
//  Created by Ashish Dwivedi on 22/01/23.
//

import SwiftUI

struct Chips: View {
    @Binding var tags: [[Tag]]
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Provide additional feedback?")
                .multilineTextAlignment(.center)
                .font(.caption)
                .foregroundColor(.gray)
            ForEach(tags.indices, id: \.self) { index in
                HStack(spacing: 8) {
                    ForEach(tags[index].indices, id: \.self) { itemIndex in
                        TagView(tag: tags[index][itemIndex])
                    }
                }
            }
        }
        .padding(.top, 20)
        .frame(maxWidth: .infinity)
    }
}
