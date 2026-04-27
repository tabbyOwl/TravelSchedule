//
//  StoryGridView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/21.
//
import SwiftUI

struct StoryStackCellView: View {
    
    //MARK: - Private properties
    private let preview: String
    private let text: String?
    private let isViewed: Bool
    private var animation: Namespace.ID
    
    //MARK: - Init
    init(preview: String, text: String?, isViewed: Bool, animation: Namespace.ID) {
        self.preview = preview
        self.text = text
        self.isViewed = isViewed
        self.animation = animation
    }
    
    //MARK: - Body
    var body: some View {
        VStack {
            Image(preview)
                .resizable()
                .scaledToFit()
                .overlay(
                    Text(text ?? "")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.white)
                        .padding(.init(top: 83, leading: 8, bottom: 0, trailing: 0))
                )
        }
        .matchedGeometryEffect(id: preview, in: animation)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .frame(height: 140)
        .opacity(isViewed ? 0.5 : 1)
        .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.blueUniversal, lineWidth: isViewed ? 0 : 4)
                )
        
        
    }
}

#Preview {
    @Previewable
    @Namespace var animation
    
    StoryStackCellView(preview: "Story1Preview", text: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text", isViewed: false, animation: animation)
}
