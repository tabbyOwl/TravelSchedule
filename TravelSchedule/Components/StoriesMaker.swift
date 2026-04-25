//
//  StoriesMaker.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/23.
//

final class StoriesMaker {
    
    static func makeStoriesGroups() -> [StoryGroup] {
        let text = "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        return (0...8).map { index in
        let storyNumber = index + 1
          return StoryGroup(id: index, title: text, previewImage: "Story\(storyNumber)Preview",
                stories: [
                    Story(id: 0, backgroundImage: "Story\(storyNumber)First", title: text, description: text),
                    Story(id: 1, backgroundImage: "Story\(storyNumber)Second", title: text, description: text)
                ])
        }
    }
}
