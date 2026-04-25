//
//  TimeIntervals.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//

struct TimeIntervals {
    static let intervals: [ScheduleInterval] = [
        ScheduleInterval(id: "morning", label: "Утро", startTime: "06:00", endTime: "12:00"),
        ScheduleInterval(id: "day", label: "День", startTime: "12:00", endTime: "18:00"),
        ScheduleInterval(id: "evening", label: "Вечер", startTime: "18:00", endTime: "00:00"),
        ScheduleInterval(id: "night", label: "Ночь", startTime: "00:00", endTime: "06:00")
    ]
}
