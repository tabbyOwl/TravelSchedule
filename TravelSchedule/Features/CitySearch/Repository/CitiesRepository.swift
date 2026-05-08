//
//  CitiesRepository.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/5/7.
//
import Logging
import Foundation
import SwiftData

struct CitiesData {
    let cities: [Settlement]
    let displayedCities: [Settlement]
}

@ModelActor
actor CitiesRepository {
    
    private let logger = Logger(label: "CitiesRepository")
    
    func loadCities() throws -> CitiesData {
        
        let descriptor = FetchDescriptor<SettlementEntity>()
        
        let entities = try modelContext.fetch(descriptor)
        
        let displayedCitiesNames = DisplayedData.citiesList
        
        let orderMap = Dictionary(uniqueKeysWithValues: displayedCitiesNames.enumerated().map { ($0.element, $0.offset)})
        
        let displayedEntities = entities.filter {
            displayedCitiesNames.contains($0.title)
        }
        
        let displayedCities = displayedEntities.map {
            Settlement(
                id: $0.id,
                title: $0.title,
                stations: $0.stations.map {
                    Station(
                        id: UUID(),
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
                        id: UUID(),
                        title: $0.title,
                        code: $0.code
                    )
                }
            )
        }
        print(cities.count, displayedCities.count)
        return CitiesData(
            cities: cities,
            displayedCities: displayedCities
        )
    }
    
    func saveSettlements(_ settlements: [Components.Schemas.Settlement]) throws {

        logger.info("Saving to swiftData...")

        for settlement in settlements {
            guard let id = settlement.codes?.yandex_code else { continue}

            let descriptor = FetchDescriptor<SettlementEntity>(
                predicate: #Predicate { $0.id == id })

            let existing = try modelContext.fetch(descriptor).first

            if existing != nil {
                continue
            }

            guard let entity = SettlementEntity(from: settlement)
            else {
                continue
            }

            modelContext.insert(entity)
        }

        try modelContext.save()

        logger.info("Successfully saved to swiftData")
    }
}
