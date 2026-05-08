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
    // MARK: - Private Properties
    private let logger = Logger(label: "CitySearchViewModel")
    private let repository: CitiesRepository
    private let serviceFactory: ServiceFactoryProtocol
    private let stationsListService: StationsListServiceProtocol
    private let nearestStationsService: NearestStationsServiceProtocol
    
    private var isLoading: Bool = false
    private var cities: [Settlement] = []
    private var _searchText: String = ""
    
    private var loadedDisplayedCities: [Settlement] = []
    
    private let placeholderCities = DisplayedData.citiesList.map {
        Settlement(id: $0,title: $0,stations: [])
    }
    
    var displayedCities: [Settlement] {
        loadedDisplayedCities.isEmpty ? placeholderCities : loadedDisplayedCities
    }
    
    // MARK: - Computed Properties
    var searchText: String {
        get { _searchText }
        set { _searchText = newValue }
    }
    
    var shouldShowSearchLoading: Bool {
        isLoading && !searchText.isEmpty
    }
    
    var hasNoResults: Bool {
        !_searchText.isEmpty && filteredCities.isEmpty && !isLoading
    }
    
    /// Фильтрует города по поисковому запросу и сортирует их по релевантности:
    /// - Сначала города, название которых начинается с запроса
    /// - Затем города, содержащие запрос в любом месте
    /// - Внутри групп сортировка по алфавиту
    var filteredCities: [Settlement] {
        guard !_searchText.isEmpty else { return displayedCities }
        
        let lowercasedQuery = _searchText.lowercased()
        
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
    init(serviceFactory: ServiceFactoryProtocol, modelContext: ModelContext) {
        self.serviceFactory = serviceFactory
        self.repository = CitiesRepository(modelContainer: modelContext.container)
        do {
            self.stationsListService = try serviceFactory.makeService(StationsListService.self)
            self.nearestStationsService = try serviceFactory.makeService(NearestStationsService.self)
        } catch {
            fatalError("Ошибка при создании сервиса: \(error)")
        }
    }
    
    // MARK: - Public methods
    func loadCities() async {
        
        do {
            let data = try await repository.loadCities()
            
            self.loadedDisplayedCities = data.displayedCities
            self.cities = data.cities
            
            if !cities.isEmpty {
                logger.info("Loaded from database")
                return
            }
        } catch {
            logger.error("DB error: \(error)")
        }
        await fetchAllStations()
    }
    
    
    
    func fetchAllStations() async {
        isLoading = true
        errorMode = nil
        
        defer {
            isLoading = false
        }
        
        do {
            let allStations = try await stationsListService.getAllStations()
            logger.info("Fetching stations...")
            
            let allSettlements = allStations.countries?
                .flatMap { $0.regions ?? [] }
                .flatMap { $0.settlements ?? [] }
            
            guard let allSettlements else { return }
            
            let settlementsWithTrainStations = allSettlements.filter({ settlement in
                guard let stations = settlement.stations else { return false }
                return stations.contains(where: { ($0.station_type == "train_station" || $0.station_type == "station") && $0.transport_type == "train" })
            })
            
            logger.info("Successfully fetched stations list.")
            try await repository.saveSettlements(settlementsWithTrainStations)
            
            let data = try await repository.loadCities()
            self.loadedDisplayedCities = data.displayedCities
            self.cities = data.cities
            
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
    
}
