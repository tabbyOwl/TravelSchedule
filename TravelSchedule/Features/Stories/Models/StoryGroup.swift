//
//  StoryGroup.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/26.
//

struct StoryGroup: Identifiable {
    let id: Int
    let title: String?
    let previewImage: String
    let stories: [Story]
    let isViewed: Bool = false
}
