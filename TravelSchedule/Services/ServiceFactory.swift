//
//  ServiceFactory.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/5/2.
//

import Foundation
import OpenAPIURLSession

enum APIKeyError: Error {
    case keyNotFound
    case invalidKey
}

protocol ServiceFactoryProtocol {
    func makeScheduleService() -> ScheduleBetweenStationsProtocol
    func makeStationsService() -> StationsListServiceProtocol
    func makeCarrierInfoService() -> CarrierInfoServiceProtocol
}

final class ServiceFactory: ServiceFactoryProtocol {
    
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func makeScheduleService() -> ScheduleBetweenStationsProtocol {
        ScheduleBetweenStationsService(client: client, apikey: apiKey)
    }
    
    func makeStationsService() -> StationsListServiceProtocol {
        StationsListService(client: client, apikey: apiKey)
    }
    
    func makeCarrierInfoService() -> CarrierInfoServiceProtocol {
        CarrierInfoService(client: client, apikey: apiKey)
    }
}
