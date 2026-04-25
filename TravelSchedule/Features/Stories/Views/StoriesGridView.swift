//
//  StoriesGridView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/21.
//
import SwiftUI

struct StoriesGridView: View {
    
    let storiesGroups: [StoryGroup]
    let rows = [GridItem(.fixed(92))]
    @Binding var selectedGroup: StoryGroup?
    @Binding var isPresented: Bool
    
    var body: some View {
        
        ScrollView (.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, spacing: 12) {
                ForEach(storiesGroups) { group in
                    StoryGridCellView(preview: group.previewImage, text: group.title)
                        .onTapGesture {
                            selectedGroup = group
                            withAnimation(.easeIn(duration: 0.1)) {
                                isPresented.toggle()
                            }
                        }
                }
            }
        }
        
    }
}


#Preview {
    StoriesGridView(storiesGroups: mockStoryGroups, selectedGroup: .constant(.group1), isPresented: .constant(true))
}
