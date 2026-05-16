//
//  NetworkClient.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/5/15.
//
import Foundation
import OpenAPIRuntime

actor NetworkClient {

    private let client: Client
    private let apiKey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apiKey = apikey
    }

    func getAllStations() async throws -> AllStations {
        let response = try await client.getAllStations(
            query: .init(apikey: apiKey)
        )

        var fullData = Data()

        let stream = try await response.ok.body.text_html_charset_utf_hyphen_8

        for try await chunk in stream {
            fullData.append(contentsOf: chunk)
        }
        
        return try await MainActor.run {
               try JSONDecoder().decode(AllStations.self, from: fullData)
           }
    }
    
    func getScheduleBetweenStations(from: String, to: String) async throws -> ScheduleBetweenStations {
        let response = try await client.getSchedualBetweenStations(query: .init(
                    apikey: apiKey,
                    from: from,
                    to: to
                )
            )
            return try await response.ok.body.json

        }

        

    func getCarrierInfo(code: String) async throws -> CarrierInfo {
        let response = try await client.getCarrierInfo(query: .init(
                apikey: apiKey,
                code: code
            )
        )
        return try await response.ok.body.json
    }
}

