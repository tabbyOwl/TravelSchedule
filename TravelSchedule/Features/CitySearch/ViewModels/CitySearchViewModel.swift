//
//  CitySearchViewModel.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//
import Foundation
import Logging
import SwiftUI
import SwiftData
import OpenAPIRuntime

@MainActor
@Observable
class CitySearchViewModel {
    
    var errorMode: ErrorMode?
    var searchText: String = ""
    // MARK: - Private Properties
    private let logger = Logger(label: "CitySearchViewModel")
    private let repository: CitiesRepository
    private let stationsListService: StationsListServiceProtocol
    
    private var isLoading: Bool = false
    private var cities: [Settlement] = []
    
    
    private var loadedDisplayedCities: [Settlement] = []
    
    private var placeholderCities: [Settlement] {
        DisplayedData.citiesList.map {
            Settlement(id: $0, title: $0, stations: [])
        }
    }
    
    var displayedCities: [Settlement] {
        loadedDisplayedCities.isEmpty ? placeholderCities : loadedDisplayedCities
    }
    
    // MARK: - Computed Properties
   
    var shouldShowSearchLoading: Bool {
        isLoading && !searchText.isEmpty
    }
    
    var hasNoResults: Bool {
        !searchText.isEmpty && filteredCities.isEmpty && !isLoading
    }
    
    /// Фильтрует города по поисковому запросу и сортирует их по релевантности:
    /// - Сначала города, название которых начинается с запроса
    /// - Затем города, содержащие запрос в любом месте
    /// - Внутри групп сортировка по алфавиту
    var filteredCities: [Settlement] {
        guard !searchText.isEmpty else { return displayedCities }
        
        let lowercasedQuery = searchText.lowercased()
        
        return cities
            .filter {
                $0.title.lowercased().contains(lowercasedQuery)
            }
            .sorted { lhs, rhs in
                let lhsStarts = lhs.title.lowercased().hasPrefix(lowercasedQuery)
                let rhsStarts = rhs.title.lowercased().hasPrefix(lowercasedQuery)
                
                if lhsStarts != rhsStarts {
                    return lhsStarts
                }
                return lhs.title < rhs.title
            }
    }
    
    // MARK: - Init
    init(
        repository: CitiesRepository,
        stationsListService: StationsListServiceProtocol
    ) {

        self.repository = repository
        self.stationsListService = stationsListService
    }
    
    // MARK: - Public methods
    func loadCities() async {
        
        do {
            try await updateCitiesFromDatabase()
            
            if !cities.isEmpty {
                logger.info("Loaded from database")
                return
            }
        } catch {
            logger.error("DB error: \(error)")
        }
        await fetchAllStations()
    }
    
    func loadCitiesFromDataBase() async {
        
    }
    
    func fetchAllStations() async {
        isLoading = true
        errorMode = nil
        
        defer {
            isLoading = false
        }
        
        do {
            logger.info("Fetching stations...")
            let allStations = try await stationsListService.getAllStations()
           
            let allSettlements = allStations.countries?
                .flatMap { $0.regions ?? [] }
                .flatMap { $0.settlements ?? [] }
            
            guard let allSettlements else { return }
            
            let filteredSettlements: [Components.Schemas.Settlement] = filterSettlements(allSettlements)
            
            logger.info("Successfully fetched stations list.")
            
            try await repository.saveSettlements(filteredSettlements)
           
            try await updateCitiesFromDatabase()
            
            isLoading = false
        } catch is CancellationError {}
        catch {
            
            logger.error("\(error)")
            
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
    }
    
    //MARK: - Private methods
    private func filterSettlements(_ settlements: [Components.Schemas.Settlement]) -> [Components.Schemas.Settlement] {
        settlements.compactMap { settlement in
            
            let filteredStations = settlement.stations?.filter(isValidTrainStation) ?? []

            guard !filteredStations.isEmpty else {
                return nil
            }

            var newSettlement = settlement
            newSettlement.stations = filteredStations

            return newSettlement
        }
    }
    
    private func isValidTrainStation(_ station: Components.Schemas.Station) -> Bool {
        let validTypes = ["train_station", "station"]

        return validTypes.contains(station.station_type ?? "")
            && !(station.direction?.isEmpty ?? true)
    }
    
    private func updateCitiesFromDatabase() async throws {
        let data = try await repository.loadCities()
        
        self.loadedDisplayedCities = data.displayedCities
        self.cities = data.cities
    }
    
}
