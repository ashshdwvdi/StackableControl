//
//  AdditionalFeedback.swift
//  StackableControl
//
//  Created by Ashish Dwivedi on 22/01/23.
//

import SwiftUI

struct AdditionalFeedback: View {
    @Binding var additionalFeedback: String
    
    var body: some View {
        VStack {
            Text("Care to provide additional feedback?")
                .multilineTextAlignment(.center)
                .font(.caption)
                .foregroundColor(.gray)
            TextEditor(text: $additionalFeedback)
                .border(.black)
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
        }
        .padding(12)
    }
}
