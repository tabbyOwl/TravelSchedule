//
//  Repositories.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/5/16.
//

final class MockCarrierInfoRepository: CarrierInfoRepositoryProtocol {
    
    func save(for code: String, carrierInfo: Components.Schemas.CarrierResponse) async throws {}
    
    func load(for code: String) throws -> Carrier? {
        Carrier(title: "Аэрофлот",
                phone: "+7 800 444-55-55",
                email: "info@aeroflot.ru",
                logo: nil
        )
    }
}

final class MockCitiesWithStationsRepository: CitiesWithStationsRepositoryProtocol {
    func load() async throws -> CitiesData {
        CitiesData(cities: mockCitiesList, displayedCities: mockCitiesList)
    }
    
    func save(_ settlements: [Components.Schemas.Settlement]) async throws {}
}

final class MockRouteRepository: RouteRepositoryProtocol {
    func loadSchedule(for routeId: String) async throws -> [Segment] {
        return mockSegments
    }
    
    func saveSchedule(for roureId: String, segments: [Components.Schemas.Segment]) async throws {}
    
}
