//
//  StoryView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/21.
//

import SwiftUI

struct StoryView: View {
    let story: Story
    
    var body: some View {
        ZStack {
            Color.blackUniversal
                .ignoresSafeArea()
            Image(story.backgroundImage)
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 40))
        }
        .overlay(
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    Text(story.title)
                        .font(.system(size: 34, weight: .bold))
                        .lineLimit(2)
                        .foregroundColor(.white)
                    Text(story.description)
                        .font(.system(size: 20, weight: .regular))
                        .lineLimit(3)
                        .foregroundColor(.white)
                }
            }
                .padding(.init(top: 0, leading: 16, bottom: 40, trailing: 16))
        )
    }
}

#Preview {
    StoryView(story: mockStoryGroups[5].stories[1])
}
