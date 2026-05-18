//
//  CarrierInfoService.swift
//  Trains
//
//  Created by Svetlana on 2026/3/29.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias CarrierInfo = Components.Schemas.CarrierResponse

protocol CarrierInfoServiceProtocol {
    func getCarrierInfo(code: String) async throws -> CarrierInfo
}

final class CarrierInfoService: CarrierInfoServiceProtocol {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getCarrierInfo(code: String) async throws -> CarrierInfo {
        try await networkClient.getCarrierInfo(code: code)
    }
}
