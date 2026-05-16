//
//  CarrierInfoRepository.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/5/14.
//
import SwiftData
import Logging
import Foundation


protocol CarrierInfoRepositoryProtocol {
    func save(for code: String, carrierInfo: Components.Schemas.CarrierResponse) async throws
    func load(for code: String) async throws -> Carrier?
}

@ModelActor
actor CarrierInfoRepository: CarrierInfoRepositoryProtocol {
    
    private let logger = Logger(label: "CarrierInfoRepository")
    
    func load(for code: String) async throws -> Carrier? {
        let descriptor = FetchDescriptor<CarrierEntity>(
            predicate: #Predicate { $0.code == code }
        )
        
        let carrierInfo = try modelContext.fetch(descriptor)
            
        guard let info = carrierInfo.first else {
            return nil
        }
        
        return Carrier(title: info.title,
                       phone: info.phone,
                       email: info.email,
                       logo: info.logo)
    }
    
    func save(for code: String, carrierInfo: Components.Schemas.CarrierResponse) async throws {
    
        let descriptor = FetchDescriptor<CarrierEntity>(
            predicate: #Predicate { $0.code == code }
        )
        
        guard let carrier = carrierInfo.carrier,
              let title = carrier.title
        else { return }
        
        if let existing = try modelContext.fetch(descriptor).first {
            existing.title = title
            existing.phone = carrier.phone
            existing.email = carrier.email
            existing.logo = carrier.logo
        } else {
            
            let entity = CarrierEntity(code: code,
                                       title: title,
                                       phone: carrier.phone,
                                       email: carrier.email,
                                       logo: carrier.logo)
            
            
            modelContext.insert(entity)
        }
            try modelContext.save()
            logger.info("Successfully saved to swiftData")
        }
    }



