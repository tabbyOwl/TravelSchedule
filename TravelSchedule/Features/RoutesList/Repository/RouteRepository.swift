//
//  ScheduleRepository.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/5/9.
//

import Logging
import SwiftData
import Foundation

@ModelActor
actor RouteRepository {
    
    private let logger = Logger(label: "RouteRepository")
    
    func loadSchedule(for routeId: String) throws -> [Segment] {
        let descriptor = FetchDescriptor<RouteEntity>(
               predicate: #Predicate { $0.id == routeId }
           )
        
           guard let route = try modelContext.fetch(descriptor).first else {
               return []
           }
        
        let segments = route.segments.map {
            
            Segment(id: $0.id.uuidString,
                    carrierName: $0.carrierName,
                    carrierCode: $0.carrierCode,
                    logo: $0.logo,
                    hasTransfers: $0.hasTransfers ?? false,
                    departure: $0.departure,
                    arrival: $0.arrival,
                    duration: $0.duration,
                    date: $0.date)
        }
        
        return segments
    }
    
    func saveSchedule(for routeId: String, segments: [Components.Schemas.Segment]) throws {
        logger.info("Saving to swiftData...")
        print("SAVE \(routeId)")
        let descriptor = FetchDescriptor<RouteEntity>(
            predicate: #Predicate { $0.id == routeId }
        )
        
        var routeEntity = RouteEntity(id: routeId)
        
        
        if let existing = try modelContext.fetch(descriptor).first {
            routeEntity = existing
            routeEntity.segments.removeAll()
        } else {
            routeEntity = RouteEntity(id: routeId)
            modelContext.insert(routeEntity)
        }
        
        for segment in segments {
            guard
                let carrierName = segment.thread?.carrier?.title,
                let carrierCode = segment.thread?.carrier?.code,
                let departure = segment.departure,
                let arrival = segment.arrival,
                let duration = segment.duration,
                let date = segment.start_date
            else { continue }
            
            let entity = SegmentEntity(carrierName: carrierName,
                                 carrierCode: carrierCode,
                                 logo: segment.thread?.carrier?.logo,
                                 hasTransfers: segment.has_transfers ?? false,
                                 departure: departure,
                                 arrival: arrival,
                                 duration: duration,
                                 date: date)
            for segment in routeEntity.segments {
                segment.route = routeEntity
            }
            routeEntity.segments.append(entity)
            
            let all = try modelContext.fetch(FetchDescriptor<RouteEntity>())
            print(all.count)
        }
        
        try modelContext.save()
        logger.info("Successfully saved to swiftData")
    }
}
