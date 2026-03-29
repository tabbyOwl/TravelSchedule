//
//  RouteStationsService.swift
//  Trains
//
//  Created by Svetlana on 2026/3/29.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias RouteStations = Components.Schemas.ThreadStationsResponse

protocol RouteStationsProtocol {
    func getRouteStations(thread: String, date: String) async throws -> RouteStations
}

final class RouteStationsService: RouteStationsProtocol, APIService  {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getRouteStations(thread: String, date: String) async throws -> RouteStations{
        let response = try await client.getRouteStations(query: .init(
            apikey: apikey,
            uid: thread,
            date: date
        ))
        return try response.ok.body.json
    }
}
