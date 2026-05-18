//
//  StoriesGridView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/21.
//
import SwiftUI

struct StoriesHStackView: View {
    
    @State private var storiesGroups: [StoryGroup] = []
    //MARK: - Bindings
    @Binding private var viewedStories: [Int]
    @Binding private var selectedGroup: StoryGroup?
    @Binding private var isPresented: Bool
    
    //MARK: - Private properties
    
    private let animation: Namespace.ID
    
    //MARK: - Init
    init(viewedStories: Binding<[Int]>,
         selectedGroup: Binding<StoryGroup?>,
         isPresented: Binding<Bool>,
         animation: Namespace.ID) {
        
        _viewedStories = viewedStories
        _selectedGroup = selectedGroup
        _isPresented = isPresented
        self.animation = animation
    }
    
    //MARK: - Body
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(storiesGroups) { group in
                    let isViewed = group.stories.allSatisfy { story in
                        viewedStories.contains(story.id)
                    }
                    
                    let viewModel = StoryStackCellViewModel(preview: group.previewImage,
                                                                title: group.title,
                                                                isViewed: isViewed)
                    StoryStackCellView(viewModel: viewModel,
                                       animation: animation)
                    .onTapGesture {
                        selectedGroup = group
                        withAnimation(.linear(duration: 0.3)) {
                            isPresented = true
                        }
                    }
                }
            }
            .padding(.init(top: 24, leading: 16, bottom: 24, trailing: 0))
            .frame(maxHeight: .infinity)
            .fixedSize(horizontal: false, vertical: true)
        }
        .onAppear {
            self.storiesGroups = StoriesMaker.makeStoriesGroups()
        }
    }
}

#Preview {
    @Previewable
    @Namespace var animation
    StoriesHStackView(viewedStories: .constant([]),
                      selectedGroup: .constant(mockStoryGroups.first),
                      isPresented: .constant(false),
                      animation: animation)
}

