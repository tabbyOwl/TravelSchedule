//
//  MainStoriesView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/21.
//

import SwiftUI

struct MainStoriesView: View {
    private let stories: [Story]
    @Binding var isPresented: Bool
    
    init(stories: [Story], isPresented: Binding<Bool>) {
        self.stories = stories
        _isPresented = isPresented
    }
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoriesView(stories: stories)
            CloseButton(action: {
                withAnimation(.easeOut) {
                    isPresented = false
                }
            })
            .padding(.top, 57)
            .padding(.trailing, 12)
        }
        .toolbarVisibility(.hidden, for: .tabBar)
    }
}

#Preview {
    MainStoriesView(stories: mockStoryGroups[0].stories, isPresented: .constant(true))
}
