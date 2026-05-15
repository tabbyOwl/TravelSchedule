//
//  CarrierInfoViewModel.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/20.
//
import SwiftUI
import Logging

@Observable
final class CarrierInfoViewModel {
    
    //MARK: - Private properties
    private let logger = Logger(label: "CarrierInfoViewModel")
    private var code: String
    private let carrierInfoService: CarrierInfoServiceProtocol
    private let repository: CarrierInfoRepository
    private(set) var carrier: Carrier = .empty
    private(set) var isLoading = false
    private(set) var state: ViewState = .loading
    
    //MARK: - Init
    init(code: String, carrierInfoService: CarrierInfoServiceProtocol, repository: CarrierInfoRepository) {
        self.code = code
        self.carrierInfoService = carrierInfoService
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
        state = .loading
     
        do {
            let carrier = try await carrierInfoService.getCarrierInfo(code: code)
            try await repository.saveCarrierInfo(for: code, carrierInfo: carrier)
            try await updateCarrierInfoFromDataBase()
        } catch {
            state = .failed
        }
    }
    
    private func updateCarrierInfoFromDataBase() async throws {
        if let data = try await repository.loadCarrierInfo(for: code) {
            carrier = data
            logger.info("Loaded from database")
            state = .loaded
        }
    }
}
