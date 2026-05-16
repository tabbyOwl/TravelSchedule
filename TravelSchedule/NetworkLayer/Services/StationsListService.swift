//
//  StationsService.swift
//  Trains
//
//  Created by Svetlana on 2026/3/29.
//
import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias AllStations = Components.Schemas.AllStationsResponse

protocol StationsListServiceProtocol {
    func getAllStations() async throws -> AllStations
}

final class StationsListService: StationsListServiceProtocol {

    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func getAllStations() async throws -> AllStations {
        try await networkClient.getAllStations()
    }
}
