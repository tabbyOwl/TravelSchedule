//
//  StationScheduleService.swift
//  Trains
//
//  Created by Svetlana on 2026/3/29.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias StationSchedule = Components.Schemas.ScheduleResponse

protocol StationScheduleProtocol {
    func getStationSchedule(station: String, date: String) async throws -> StationSchedule
}

final class StationScheduleService: StationScheduleProtocol, APIService {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getStationSchedule(station: String, date: String) async throws -> StationSchedule {
        let response = try await client.getStationSchedule(query: .init(
            apikey: apikey,
            station: station,
            date: date
            
        ))
        return try response.ok.body.json
    }
}
