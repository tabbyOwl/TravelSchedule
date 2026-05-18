//
//  StoryView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/21.
//

import SwiftUI

struct StoryView: View {
    
    //MARK: - Private properties
    private let story: Story
    
    //MARK: - Init
    init(story: Story) {
        self.story = story
    }
    
    //MARK: - Body
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            Image(story.backgroundImage)
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .ignoresSafeArea(edges: .horizontal)
                .padding(.top)
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
    StoryView(story: mockStoryGroups[0].stories[0])
}
