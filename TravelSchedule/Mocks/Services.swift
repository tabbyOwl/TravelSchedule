//
//  Services.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/5/16.
//

final class MockCarrierInfoService: CarrierInfoServiceProtocol {
    
    func getCarrierInfo(code: String) async throws -> CarrierInfo {
        CarrierInfo()
    }
}


final class MockStationsListService: StationsListServiceProtocol {
    func getAllStations() async throws -> AllStations {
        AllStations()
    }
}


final class MockScheduleService: ScheduleBetweenStationsProtocol {
    func getScheduleBetweenStations(from: String, to: String) async throws -> ScheduleBetweenStations {
        ScheduleBetweenStations()
    }
}
