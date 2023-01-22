//
//  StackContentView.swift
//  StackableControl
//
//  Created by Ashish Dwivedi on 22/01/23.
//

import SwiftUI

struct StackContentView: View, PageSelecting {
    private let driver = PagesDriver(minimumPages: 2, maximumPages: 4)
    
    @ObservedObject var viewModel = ViewModel()
    @State var stack: [StackPageView] = []
    
    var body: some View {
        ZStack {
            VStack {
                ForEach(stack.indices, id: \.self) { index in
                    stack[index]
                        .frame(maxHeight: stack[index].asset.isExpanded ? .infinity : 64)
                }
                .transition(.move(edge: .bottom))
                Spacer()
                Button {
                    withAnimation {
                        start()
                    }
                } label: {
                    Text(driver.selectedPage?.asset.ctaText ?? "Start")
                        .font(.callout)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding(20)
                        .background(Color.black)
                        .cornerRadius(25, corners: [.topLeft, .topRight])
                }
            }
        }
        .padding(.top, 20)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            createAssets()
        }
    }
    
    private func createAssets() {
        let feedback = FeedbackView(isLike: viewModel.isLiked, isDislike: viewModel.isDisliked)
        let chips = Chips(tags: $viewModel.tags)
        let additionalFeedback = AdditionalFeedback(additionalFeedback: $viewModel.additionalFeedback)
        let toast = GreetingsView()
        
        compose(
            expandedView: AnyView(feedback),
            collapsedView: AnyView(createText("Completed step 1 of 3")),
            buttonText: "Submit"
        )
        compose(
            expandedView: AnyView(chips),
            collapsedView: AnyView(createText("Completed step 2 of 3")),
            buttonText: "Select"
        )
        compose(
            expandedView: AnyView(additionalFeedback),
            collapsedView: AnyView(createText("Completed step 3 of 3")),
            buttonText: "Done"
        )
        compose(expandedView: AnyView(toast), collapsedView: nil, buttonText: "bye!")
        
        start()
    }
    
    private func start() {
        driver.next()
        if let page = driver.selectedPage {
            stack.append(page)
        } else {
            stack.removeAll()
        }
    }
    
    private func compose(expandedView: AnyView, collapsedView: AnyView?, buttonText: String) {
        let asset = Asset(
            expandedView: expandedView,
            collapsedView: collapsedView,
            buttonText: buttonText
        )
        var page = StackPageView(asset: asset)
        page.delegate = self
        
        driver.add(page: page)
    }
    
    @ViewBuilder
    private func createText(_ string: String) -> some View {
        Text(string)
            .multilineTextAlignment(.center)
            .font(.headline)
            .foregroundColor(.black)
    }
    
    // MARK: - PageSelecting
    
    func select(pageId: UUID) {
        driver.select(pageId: pageId)
        
        var preservedPages = 0
        for index in stride(from: 0, to: stack.count, by: 1) {
            preservedPages += 1
            if stack[index].asset.id == pageId {
                break
            }
        }
        
        withAnimation {
            stack.removeLast(stack.count - preservedPages)
        }
    }
}
