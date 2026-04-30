//
//  StoryGridView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/21.
//
import SwiftUI

struct StoryStackCellView: View {
    
    //MARK: - Private properties
    private let viewModel: StoryStackCellViewModel
    private var animation: Namespace.ID
    
    //MARK: - Init
    init(viewModel: StoryStackCellViewModel, animation: Namespace.ID) {
        self.viewModel = viewModel
        self.animation = animation
    }
    
    //MARK: - Body
    var body: some View {
        VStack {
            Image(viewModel.preview)
                .resizable()
                .scaledToFit()
                .overlay(
                    Text(viewModel.title)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.white)
                        .padding(.init(top: 83, leading: 8, bottom: 0, trailing: 0))
                )
        }
       
        .matchedGeometryEffect(id: viewModel.preview, in: animation)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .frame(width: 92, height: 140)
        .opacity(viewModel.isViewed ? 0.5 : 1)
        .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.blueUniversal, lineWidth: viewModel.isViewed ? 0 : 4)
                )
        
        
    }
}

#Preview {
    @Previewable
    @Namespace var animation
    
    StoryStackCellView(viewModel: StoryStackCellViewModel(preview: "Story1Preview", title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text", isViewed: false), animation: animation)
}
