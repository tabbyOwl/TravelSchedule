//
//  RoutesListViewModel.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//
import Foundation

@Observable
class RouteListViewModel {
    
    var segments: [Segment] = mockSegments
    var selectedIntervals: Set<ScheduleInterval> = []
    var showTransfers = true
    
    // MARK: - Private Properties
    private let from: Station
    private let to: Station
    private let scheduleService: ScheduleBetweenStationsProtocol
    
    // MARK: - Computed Properties
    var filteredSegments: [Segment] {
        selectedIntervals.isEmpty ? segments :
        segments.filter { segment in
            guard let time = getMinutes(from: segment.departure) else { return false }
            
            return selectedIntervals.contains { interval in
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
    
    var isFiltersOn: Bool {
        selectedIntervals.isEmpty ? false : true
    }
    
    var routeTitle: String {
        "\(from.title) → \(to.title)"
    }
    
    // MARK: - Init
    init(from: Station, to: Station, scheduleService: ScheduleBetweenStationsProtocol) {
        self.from = from
        self.to = to
        self.scheduleService = scheduleService
    }
    
    // MARK: - Private Methods
    private func getMinutes(from time: String) -> Int? {
        let components = time.split(separator: ":")
        guard
            let hours = Int(components[0]),
            let minutes = Int(components[1]) else { return nil }
        
        return hours * 60 + minutes
    }
    
//    func loadSchedule() async {
//        _isLoading = true
//        do {
//            let schedule = try await scheduleService.getScheduleBetweenStations(from: from.code, to: to.code)
//            logger.info("Fetching schedule...")
//            guard let fetched = schedule.segments else { return }
//            self.segments = fetched.compactMap(Segment.init)
//            saveSegmentsToCache(segments)
//            logger.info(" Successfully fetched schedule...")
//        } catch {
//            logger.error("Error fetching schedule: \(error.localizedDescription)")
//        }
//        _isLoading = false
//    }
}
