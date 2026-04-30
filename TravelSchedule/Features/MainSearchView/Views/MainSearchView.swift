//
//  MainSearchView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//

import SwiftUI

struct MainSearchView: View {
    
    // MARK: - State
    @State private var viewModel = MainSearchViewModel()
    @State private var isStoryPresented: Bool = false
    @State private var selectedGroup: StoryGroup?
    @State private var viewedStories: [Int] = []
    
    @Namespace private var animation
    
    // MARK: - Init
    init(viewModel: MainSearchViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            StoriesHStackView(viewedStories: $viewedStories,
                              selectedGroup: $selectedGroup,
                              isPresented: $isStoryPresented,
                              animation: animation)
            
            
            MainSearchInputView(viewModel: $viewModel)
            
            if viewModel.areCitiesSelected {
                MainSearchSearchButton(fromStation: viewModel.fromStation, toStation: viewModel.toStation)
            }
            
            Spacer()
            
                .onAppear {
                    viewedStories = getViewedStories()
                }
                .onChange(of: isStoryPresented) { _, newValue in
                    if !newValue {
                        viewedStories = getViewedStories()
                    }
                }
        }
            .overlay {
                if let group = selectedGroup, isStoryPresented {
                    MainStoriesView(stories: group.stories, isPresented: $isStoryPresented)
                        .matchedGeometryEffect(id: group.previewImage, in: animation)
                }
            }
        
    }
    
    // MARK: - Private methods
    private func getViewedStories() -> [Int] {
        if let stories = UserDefaults.standard.array(forKey: UserDefaultsKeys.viewedStories) {
            return stories as? [Int] ?? []
        }
        return []
    }
}

#Preview {
    MainSearchView(viewModel: MainSearchViewModel())
}
