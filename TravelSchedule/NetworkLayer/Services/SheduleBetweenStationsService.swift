//
//  SheduleBetweenStationsService.swift
//  Trains
//
//  Created by Svetlana on 2026/3/29.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleBetweenStations = Components.Schemas.Segments

protocol ScheduleBetweenStationsProtocol {
    func getScheduleBetweenStations(from: String, to: String) async throws -> ScheduleBetweenStations
}

final class ScheduleBetweenStationsService: ScheduleBetweenStationsProtocol {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getScheduleBetweenStations(from: String, to: String) async throws -> ScheduleBetweenStations {
            try await networkClient.getScheduleBetweenStations(from: from,to: to)
        }
}
