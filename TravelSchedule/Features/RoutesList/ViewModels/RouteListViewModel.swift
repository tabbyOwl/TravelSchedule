//
//  RoutesListViewModel.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//
import Foundation
import Logging
import OpenAPIRuntime

@MainActor
@Observable
class RouteListViewModel {
    
    var segments: [Segment] = []
    var selectedIntervals: Set<ScheduleInterval> = []
    var showTransfers = true
    var imageLoader = ImageDownloader()
    
    // MARK: - Private Properties
    private let logger = Logger(label: "RouteListViewModel")
    private let from: Station
    private let to: Station
    private let scheduleService: ScheduleBetweenStationsProtocol
    private let repository: RouteRepositoryProtocol
    private(set) var state: ViewState = .loaded
    private(set) var errorMode: ErrorMode?
    private var isLoading = false
    
    private var routeId: String {
        "\(from.code)-\(to.code)"
    }
    // MARK: - Computed Properties
    var filteredSegments: [Segment] {
        let filtered = selectedIntervals.isEmpty ? segments :
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
        return filtered.sorted {
            return $0.departureDate < $1.departureDate
        }
    }
    
    var isFiltersOn: Bool {
        selectedIntervals.isEmpty ? false : true
    }
    
    var routeTitle: String {
        "\(from.title) → \(to.title)"
    }
    
    // MARK: - Init
    init(from: Station, to: Station, scheduleService: ScheduleBetweenStationsProtocol, repository: RouteRepositoryProtocol) {
        self.from = from
        self.to = to
        self.scheduleService = scheduleService
        self.repository = repository
    }
    
    // MARK: - Public Methods
    
    func loadSchedule() async {
        do {
            try await updateSegmentsFromDatabase()
            
            if !segments.isEmpty {
                logger.info("Loaded from database")
                return
            }
        } catch {
            logger.error("Data base error: \(error)")
        }
        await fetchSchedule()
    }
    
    func refreshSchedule() async {
        await fetchSchedule()
    }
    
    // MARK: - Private Methods
    ///число минут от начала суток
    private func getMinutes(from time: String) -> Int? {
        let components = time.split(separator: ":")
        guard
            let hours = Int(components[0]),
            let minutes = Int(components[1]) else { return nil }
        
        return hours * 60 + minutes
    }
    
    private func fetchSchedule() async {
        
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        state = .loading
        do {
            logger.info("Fetching schedule...")
            let schedule = try await scheduleService.getScheduleBetweenStations(from: from.code, to: to.code)
            
            guard let fetchedSegments = schedule.segments else { return }
            
            try await repository.saveSchedule(for: routeId, segments: fetchedSegments)
            
            try await updateSegmentsFromDatabase()
            
            logger.info(" Successfully fetched schedule...")
            state = .loaded
        } catch {
            logger.error("\(error)")
            state = .failed
            errorMode = error.asErrorMode
        }
    }
    
    private func updateSegmentsFromDatabase() async throws {
        let data = try await repository.loadSchedule(for: routeId)
        self.segments = data
    }
}
