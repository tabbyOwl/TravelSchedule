//
//  CarrierInfoViewModel.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/20.
//
import SwiftUI
import Logging
import OpenAPIRuntime

@Observable
final class CarrierInfoViewModel {
    
    //MARK: - Private properties
    private let logger = Logger(label: "CarrierInfoViewModel")
    private let service: CarrierInfoServiceProtocol
    private let repository: CarrierInfoRepositoryProtocol
    private(set) var errorMode: ErrorMode?
    private(set) var carrier: Carrier = .empty
    private(set) var state: ViewState = .loading
    private var code: String
    private var isLoading = false
    
    //MARK: - Init
    init(code: String, service: CarrierInfoServiceProtocol, repository: CarrierInfoRepositoryProtocol) {
        self.code = code
        self.service = service
        self.repository = repository
    }
    
    //MARK: - Public methods
    func loadCarrierInfo() async {
        do {
            try await updateCarrierInfoFromDataBase()
            
            if state != .loading {
                return
            }
        } catch {
            logger.error("Database error: \(error)")
        }
        await fetchCarrierInfo()
    }
    
    //MARK: - Public methods
    private func fetchCarrierInfo() async {
        
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        state = .loading
        
        do {
            let carrier = try await service.getCarrierInfo(code: code)
            try await repository.save(for: code, carrierInfo: carrier)
            try await updateCarrierInfoFromDataBase()
            state = .loaded
        } catch {
            logger.error("\(error)")
            state = .failed
            errorMode = error.asErrorMode
        }
    }
    
    private func updateCarrierInfoFromDataBase() async throws {
        if let data = try await repository.load(for: code) {
            carrier = data
            logger.info("Loaded from database")
            state = .loaded
        }
    }
}
