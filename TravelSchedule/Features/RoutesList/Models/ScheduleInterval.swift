//
//  TimeInterval.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//

struct ScheduleInterval: Identifiable, Hashable {
    var id: String
    var label: String
    var startTime: String
    var endTime: String
    
    var displayName: String {
        "\(label) \(startTime) - \(endTime)"
    }
}
