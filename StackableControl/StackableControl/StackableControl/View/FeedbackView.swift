//
//  FeedbackView.swift
//  StackableControl
//
//  Created by Ashish Dwivedi on 22/01/23.
//

import SwiftUI

struct FeedbackView: View {
    @State var isLike: Bool
    @State var isDislike: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text("I'd love to know\n if you're enjoying 😁?")
                .multilineTextAlignment(.center)
                .font(.caption)
                .foregroundColor(.gray)
            HStack(spacing: 10) {
                createButton(like: true)
                createButton(like: false)
            }
        }
        .padding(.top, 20)
    }
    
    // MARK: - Helpers
    
    @ViewBuilder
    private func createButton(like: Bool) -> some View {
        if like {
            Button {
                updateState(isLiked: true)
            } label: {
                Image(systemName: "hand.thumbsup")
                    .renderingMode(.template)
                    .foregroundColor(Color.black)
                    .frame(width: 70, height: 70)
                    .background(self.isLike ? Color.green.opacity(0.7) : Color.gray.opacity(0.1))
            }
            .cornerRadius(35)
        } else {
            Button {
                updateState(isLiked: false)
            } label: {
                Image(systemName: "hand.thumbsdown")
                    .renderingMode(.template)
                    .foregroundColor(Color.black)
                    .frame(width: 70, height: 70)
                    .background(self.isDislike ? Color.red.opacity(0.7) : Color.gray.opacity(0.1))
            }
            .cornerRadius(35)
        }
    }
    
    private func updateState(isLiked: Bool) {
        isLike = isLiked
        isDislike = !isLiked
    }
}
