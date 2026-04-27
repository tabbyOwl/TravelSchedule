//
//  StoriesGridView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/21.
//
import SwiftUI

struct StoriesHStackView: View {
    
    //MARK: - Bindings
    @Binding private var viewedStories: [Int]
    @Binding private var selectedGroup: StoryGroup?
    @Binding private var isPresented: Bool
    
    //MARK: - Private properties
    private let storiesGroups: [StoryGroup]
    private let animation: Namespace.ID
    
    //MARK: - Init
    init(viewedStories: Binding<[Int]>,
         selectedGroup: Binding<StoryGroup?>,
         isPresented: Binding<Bool>,
         storiesGroups: [StoryGroup],
         animation: Namespace.ID) {
        
        _viewedStories = viewedStories
        _selectedGroup = selectedGroup
        _isPresented = isPresented
        self.storiesGroups = storiesGroups
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
                    StoryStackCellView(preview: group.previewImage, text: group.title, isViewed: isViewed, animation: animation)
                        .onTapGesture {
                            selectedGroup = group
                            withAnimation(.linear(duration: 0.2)) {
                                isPresented = true
                            }
                        }
                }
            }
            .padding(.init(top: 24, leading: 16, bottom: 24, trailing: 0))
            .frame(maxHeight: .infinity)
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    @Previewable
    @Namespace var animation
    StoriesHStackView(viewedStories: .constant([]), selectedGroup: .constant(mockStoryGroups.first), isPresented: .constant(false), storiesGroups: mockStoryGroups, animation: animation)
}

