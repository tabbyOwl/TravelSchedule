//
//  CitiesRepository.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/5/7.
//
import Logging
import Foundation
import SwiftData

protocol CitiesWithStationsRepositoryProtocol {
    func load() async throws -> CitiesData
    func save(_ settlements: [Components.Schemas.Settlement]) async throws
}

struct CitiesData {
    let cities: [Settlement]
    let displayedCities: [Settlement]
}

@ModelActor
actor CitiesWithStationsRepository: CitiesWithStationsRepositoryProtocol {
    
    private let logger = Logger(label: "CitiesRepository")
    
    func load() throws -> CitiesData {
        
        let descriptor = FetchDescriptor<SettlementEntity>()
        
        let entities = try modelContext.fetch(descriptor)
        
        let displayedCitiesNames = DisplayedData.citiesList
        
        let displayedEntities = entities.filter {
            displayedCitiesNames.contains($0.title)
        }
        
        let displayedCities = displayedEntities.map {
            Settlement(
                id: $0.id,
                title: $0.title,
                stations: $0.stations.map {
                    Station(
                        id: $0.code,
                        title: $0.title,
                        code: $0.code
                    )
                }
            )
        }.sorted {
            guard
                let lhsIndex = displayedCitiesNames.firstIndex(of: $0.title),
                let rhsIndex = displayedCitiesNames.firstIndex(of: $1.title)
            else {
                return false
            }
            return lhsIndex < rhsIndex
        }
        
        let cities = entities.map {
            Settlement(
                id: $0.id,
                title: $0.title,
                stations: $0.stations.map {
                    Station(
                        id: $0.code,
                        title: $0.title,
                        code: $0.code
                    )
                }
            )
        }
        
        return CitiesData(
            cities: cities,
            displayedCities: displayedCities
        )
    }
    
    func save(_ settlements: [Components.Schemas.Settlement]) throws {
        
        logger.info("Saving to swiftData...")
        
        for settlement in settlements {
            
            guard let id = settlement.codes?.yandex_code,
                  let title = settlement.title
            else {
                continue
            }
            
            let descriptor = FetchDescriptor<SettlementEntity>(
                predicate: #Predicate { $0.id == id }
            )
            
            let entity: SettlementEntity
            
            if let existing = try modelContext.fetch(descriptor).first {
                
                entity = existing
                entity.title = title
                entity.stations.removeAll()
                
            } else {
                
                entity = SettlementEntity(
                    id: id,
                    title: title,
                    stations: []
                )
                
                modelContext.insert(entity)
            }
            
            let stationsDTO = settlement.stations ?? []
            
            for dto in stationsDTO {
                guard let station = StationEntity(from: dto) else {
                    continue
                }
                
                entity.stations.append(station)
            }
        }
        
        try modelContext.save()
        
        logger.info("Successfully saved to swiftData")
    }
    
}

