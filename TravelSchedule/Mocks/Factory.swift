//
//  Factory.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/5/16.
//

final class MockServiceFactory: ServiceFactoryProtocol {
    
    lazy var scheduleService:
        any ScheduleBetweenStationsProtocol = {
            MockScheduleService()
        }()
    
    lazy var stationsService:
        any StationsListServiceProtocol = {
            MockStationsListService()
        }()
    
    lazy var carrierInfoService:
        any CarrierInfoServiceProtocol = {
            MockCarrierInfoService()
        }()
}
