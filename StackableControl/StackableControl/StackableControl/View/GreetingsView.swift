//
//  GreetingsView.swift
//  StackableControl
//
//  Created by Ashish Dwivedi on 22/01/23.
//

import SwiftUI

struct GreetingsView: View {
    var body: some View {
        Text("Thank you for submitting feedback!")
            .font(.subheadline)
            .padding(20)
            .foregroundColor(.white)
            .background(Color.green)
            .cornerRadius(24, corners: .allCorners)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
