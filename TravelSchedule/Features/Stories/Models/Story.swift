//
//  Story.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/20.
//
import SwiftUI

struct StoryGroup: Identifiable {
    let id: Int
    let title: String?
    let previewImage: String
    let stories: [Story]
    
    private let text = "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
    
    static let group1 = StoryGroup(
        id: 1,
        title: "text",
        previewImage: "Story1Preview",
        stories: [.story1, .story2])
    
    static let group2 = StoryGroup(
        id: 2,
        title: "text",
        previewImage: "Story1Preview",
        stories: [
            Story(id: 21, backgroundImage: "Story2First", title: "text", description: "text"),
            Story(id: 22, backgroundImage: "Story2Second", title: "text", description: "text")
        ])
}

struct Story: Identifiable {
    let id: Int
    let backgroundImage: String
    let title: String
    let description: String
    
    static let story1 = Story(
        id: 1,
        backgroundImage: "Story1First",
        title: "🎉 ⭐️ ❤️",
        description: "Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 "
    )

    static let story2 = Story(
        id: 2,
        backgroundImage: "Story3First",
        title: "😍 🌸 🥬",
        description: "Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 "
    )

    static let story3 = Story(
        id: 3,
        backgroundImage: "Story2First",
        title: "🧀 🥑 🥚",
        description: "Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 "
    )

}

