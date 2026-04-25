//
//  StoryGridView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/21.
//
import SwiftUI

struct StoryGridCellView: View {
    
    let preview: String
    let text: String?
    
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
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .frame(height: 140)
    }
}

#Preview {
    StoryGridCellView(preview: "Story1Preview", text: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text ")
}
