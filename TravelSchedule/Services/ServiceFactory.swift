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
    func makeService<T: APIService>(_ type: T.Type) throws -> T
}

class DefaultServiceFactory: ServiceFactoryProtocol {
    /// Функция для создания сервисов с использованием API ключа
    func makeService<T: APIService>(_ type: T.Type) throws -> T {
        let apiKeyManager = APIKeyManager()
        
        guard let apiKey = apiKeyManager.getApiKey() else {
            throw APIKeyError.keyNotFound
        }
        
        let client = try! Client(
            serverURL: Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        return T(client: client, apikey: apiKey)
    }
}
