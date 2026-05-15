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
    private let repository: RouteRepository
    private(set) var state: ViewState = .loaded
    private(set) var errorMode: ErrorMode?
    
    private var routeId: String {
        "\(from.code)-\(to.code)"
    }
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
    init(from: Station, to: Station, scheduleService: ScheduleBetweenStationsProtocol, repository: RouteRepository) {
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
    
    // MARK: - Private Methods
    ///число минут от начала суток
    private func getMinutes(from time: String) -> Int? {
        let components = time.split(separator: ":")
        guard
            let hours = Int(components[0]),
            let minutes = Int(components[1]) else { return nil }
        
        return hours * 60 + minutes
    }
    
    private func formattedDuration(_ duration: Int) -> String {
        let totalHours = duration / 3600
        
        let days = totalHours / 24
        let hours = totalHours % 24
        
        if days > 0 {
            return "\(days) д \(hours) ч"
        } else {
            return "\(hours) часов"
        }
    }
    
    private func fetchSchedule() async {
        state = .loading
        do {
            logger.info("Fetching schedule...")
            let schedule = try await scheduleService.getScheduleBetweenStations(from: from.code, to: to.code)
            
            guard let fetchedSegments = schedule.segments else { return }
            
            try await repository.saveSchedule(for: routeId, segments: fetchedSegments)
            
            try await updateSegmentsFromDatabase()
            
            logger.info(" Successfully fetched schedule...")
        } catch {
            logger.error("\(error)")
            state = .failed
            
            if let clientError = error as? ClientError {
                if let underlyingError = clientError.underlyingError as? URLError {

                    switch underlyingError.code {
                    case .notConnectedToInternet,
                            .networkConnectionLost:
                        errorMode = .noInternet
                    default:
                        errorMode = .serverError
                    }
                    return
                }
            }
            errorMode = .serverError
        }
        state = .loaded
    }
    
    private func updateSegmentsFromDatabase() async throws {
        let data = try await repository.loadSchedule(for: routeId)
        self.segments = data
    }
}
