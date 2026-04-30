//
//  RoutesListViewModel.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//
import Foundation

@Observable
class RouteListViewModel {
    
    // MARK: - Private Properties
    private let from: Station
    private let to: Station
    private var segments: [Segment] = mockSegments
    private var _selectedIntervals: Set<ScheduleInterval> = []
    private var _showTransfers = true
 
    // MARK: - Computed Properties
    var filteredSegments: [Segment] {
        _selectedIntervals.isEmpty ? segments :
        segments.filter { segment in
            guard let time = getMinutes(from: segment.departure) else { return false }
            
            return _selectedIntervals.contains { interval in
                if let startTime = getMinutes(from: interval.startTime),
                   let endTime = getMinutes(from: interval.endTime) {
                    
                    if startTime <= endTime {
                        return time >= startTime && time <= endTime
                    } else {
                        return (time >= startTime || time <= endTime)
                    }
                }
                return false
            }
        }
        .sorted { $0.date < $1.date }
    }
    
    var showTransfers: Bool {
        get {_showTransfers }
        set {
            if newValue != _showTransfers {
                _showTransfers = newValue
            }
        }
    }
    
    var selectedIntervals: Set<ScheduleInterval>  {
        get { _selectedIntervals }
        set {
            if newValue != _selectedIntervals {
                _selectedIntervals = newValue
            }
        }
    }
    
    var isFiltersOn: Bool {
        _selectedIntervals.isEmpty ? false : true
    }
    
    var routeTitle: String {
        "\(from.title) → \(to.title)"
    }
    
    // MARK: - Init
    init(from: Station, to: Station) {
        self.from = from
        self.to = to
    }
    
    // MARK: - Private Methods
    private func getMinutes(from time: String) -> Int? {
        let components = time.split(separator: ":")
        guard
            let hours = Int(components[0]),
            let minutes = Int(components[1]) else { return nil }
        
        return hours * 60 + minutes
    }
}
