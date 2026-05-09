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
    
    var stationsListService: StationsListServiceProtocol { get }
    
    var nearestStationsService: NearestStationsServiceProtocol { get }
}

final class DefaultServiceFactory: ServiceFactoryProtocol {

    let stationsListService: StationsListServiceProtocol
    let nearestStationsService: NearestStationsServiceProtocol

    init() {

        let apiKeyManager = APIKeyManager()

        guard let apiKey = apiKeyManager.getApiKey() else {
            fatalError("API key not found")
        }

        let client = try! Client(
            serverURL: Servers.Server1.url(),
            transport: URLSessionTransport()
        )

        self.stationsListService = StationsListService(
            client: client,
            apikey: apiKey
        )

        self.nearestStationsService = NearestStationsService(
            client: client,
            apikey: apiKey
        )
    }
}
