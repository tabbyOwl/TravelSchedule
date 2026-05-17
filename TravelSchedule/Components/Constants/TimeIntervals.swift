//
//  TimeIntervals.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//

struct TimeIntervals {
    static let intervals: [ScheduleInterval] = [
        ScheduleInterval(id: "morning", label: Strings.TimeIntervals.morning, startTime: "06:00", endTime: "12:00"),
        ScheduleInterval(id: "day", label: Strings.TimeIntervals.day, startTime: "12:00", endTime: "18:00"),
        ScheduleInterval(id: "evening", label: Strings.TimeIntervals.evening, startTime: "18:00", endTime: "00:00"),
        ScheduleInterval(id: "night", label: Strings.TimeIntervals.night, startTime: "00:00", endTime: "06:00")
    ]
}
