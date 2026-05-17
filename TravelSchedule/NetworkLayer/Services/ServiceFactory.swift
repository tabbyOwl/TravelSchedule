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
    
    var scheduleService: any ScheduleBetweenStationsProtocol { get }
    var stationsService: any StationsListServiceProtocol { get }
    var carrierInfoService: any CarrierInfoServiceProtocol { get }
}

final class ServiceFactory: ServiceFactoryProtocol {
    
    private let networkClient: NetworkClient
    
    init(client: Client, apiKey: String) {
        self.networkClient = NetworkClient(
            client: client,
            apikey: apiKey
        )
    }
    
    lazy var scheduleService: any ScheduleBetweenStationsProtocol = {
        ScheduleBetweenStationsService(networkClient: networkClient)
    }()
    
    lazy var stationsService: any StationsListServiceProtocol = {
        StationsListService(networkClient: networkClient)
    }()
    
    lazy var carrierInfoService: any CarrierInfoServiceProtocol = {
        CarrierInfoService(networkClient: networkClient)
    }()
}
