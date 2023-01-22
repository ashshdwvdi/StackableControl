//
//  StackPageView.swift
//  StackableControl
//
//  Created by Ashish Dwivedi on 22/01/23.
//

import SwiftUI

public struct StackPageView: View {
    @ObservedObject var asset: Asset
    var delegate: PageSelecting?
    
    public var body: some View {
        VStack {
            view()
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(24, corners: [.topLeft, .topRight])
        .shadow(color: Color.black.opacity(0.2), radius: 15, x: 0, y: -15)
    }
    
    @ViewBuilder private func view() -> some View {
        if let expanded = asset.expanded, asset.isExpanded {
            expanded
        } else if let collapsed = asset.collapsed {
            HStack {
                collapsed
                Image(systemName: "chevron.down")
                    .frame(width: 14, height: 14)
            }
            .padding([.top, .bottom], 40)
            .padding(.trailing, 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.35))
            .onTapGesture {
                delegate?.select(pageId: asset.id)
            }
        } else {
            EmptyView()
        }
    }
}
