//
//  AppAssembly.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/5/9.
//

import OpenAPIURLSession

enum AppAssembly {

    static func makeFactory() throws -> ServiceFactory {

        let apiKeyManager = APIKeyManager()

        guard let apiKey = apiKeyManager.getApiKey() else {
            throw APIKeyError.keyNotFound
        }

        let client = try Client(
            serverURL: Servers.Server1.url(),
            transport: URLSessionTransport()
        )

        return ServiceFactory(client: client, apiKey: apiKey)
    }
}
