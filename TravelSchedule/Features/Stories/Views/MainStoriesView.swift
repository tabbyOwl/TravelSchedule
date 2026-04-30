//
//  MainStoriesView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/21.
//

import SwiftUI

struct MainStoriesView: View {
    
    //MARK: - Bindings
    @Binding private var isPresented: Bool
    
    //MARK: - Private properties
    private let stories: [Story]
   
    //MARK: - Init
    init(stories: [Story], isPresented: Binding<Bool>) {
        self.stories = stories
        _isPresented = isPresented
    }
    
    //MARK: - Body
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoriesView(isPresented: $isPresented, stories: stories)
            
            CloseButton(action: {
                withAnimation(.linear(duration: 0.3)) {
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
