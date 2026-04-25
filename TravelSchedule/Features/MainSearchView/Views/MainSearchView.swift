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
    @State private var selectedStory: StoryGroup?

    // MARK: - Init
    init(viewModel: MainSearchViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            let groups = StoriesMaker.makeStoriesGroups()
            
            StoriesGridView(storiesGroups: groups, selectedGroup: $selectedStory, isPresented: $isStoryPresented)
                .frame(height: 140)
                .padding(.init(top: 24, leading: 16, bottom: 24, trailing: 0))
            
            MainSearchInputView(viewModel: $viewModel)
          
            if viewModel.areCitiesSelected {
                MainSearchSearchButton(fromStation: viewModel.fromStation, toStation: viewModel.toStation)
            }
            
            Spacer()
        }

        .overlay(
            ZStack {
                if isStoryPresented {
                    MainStoriesView(stories: selectedStory?.stories ?? [], isPresented: $isStoryPresented)
                        .transition(.opacity)
                        .onTapGesture {
                                isStoryPresented = true
                        }
                }
            }
        )
    }
    
}

#Preview {
    MainSearchView(viewModel: MainSearchViewModel())
}
