//
//  RoutesListViewModel.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//
import Combine

class RouteListViewModel: ObservableObject {
    
    private let from: Station
    private let to: Station
    
    @Published private var segments: [Segment] = mockSegments
    @Published var selectedIntervals: Set<TimeInterval> = []
    @Published var showTransfers = true
 
    var filteredSegments: [Segment] {
        selectedIntervals.isEmpty ? segments :
        segments.filter { segment in
            guard let time = getMinutes(from: segment.departure) else { return false }
            return selectedIntervals.contains { interval in
                if let startTime = getMinutes(from: interval.startTime),
                   let endTime = getMinutes(from: interval.endTime) {
                    return time >= startTime && time <= endTime
                }
                return false
            }
        }
        .sorted { $0.date < $1.date }
    }
    
    var isFiltersOn: Bool {
        selectedIntervals.isEmpty ? false : true
    }
    
    var routeTitle: String {
        "\(from.title) → \(to.title)"
    }
    
    init(from: Station, to: Station) {
        self.from = from
        self.to = to
    }
    
    private func getMinutes(from time: String) -> Int? {
        let components = time.split(separator: ":")
        guard
            let hours = Int(components[0]),
            let minutes = Int(components[1]) else { return nil }
        
        return hours * 60 + minutes
    }
}
