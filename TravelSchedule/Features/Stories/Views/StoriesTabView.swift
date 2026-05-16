//
//  StoriesTabView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/21.
//

import SwiftUI

struct StoriesTabView: View {
    
    //MARK: - Bindings
    @Binding private var currentStoryIndex: Int
    
    //MARK: - Private properties
    private let stories: [Story]
    
    //MARK: - Init
    init(currentStoryIndex: Binding<Int>, stories: [Story]) {
        _currentStoryIndex = currentStoryIndex
        self.stories = stories
    }
    
    //MARK: - Body
    var body: some View {
        TabView(selection: $currentStoryIndex) {
            ForEach(Array(stories.enumerated()), id: \.element.id) { index, story in
                StoryView(story: story)
                    .tag(index)
                    .onTapGesture {
                        didTapStory()
                    }
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }

    func didTapStory() {
        currentStoryIndex = min(currentStoryIndex + 1, stories.count - 1)
    }
}

#Preview {
    StoriesTabView(currentStoryIndex: .constant(0),
                   stories: mockStoryGroups[1].stories)
}
