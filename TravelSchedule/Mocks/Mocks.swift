//
//  Mock.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//
import SwiftUI

// MARK: - Stations
let baseStations = [
    "Казанский вокзал",
    "Курский вокзал",
    "Ярославский вокзал",
    "Ленинградский вокзал"
]

let mockStations = baseStations.map { title in
    Station(id: title, title: title, code: "")
}

// MARK: - Cities
func createCity(_ city: String) -> Settlement {
    return Settlement(id: UUID().uuidString, title: city, stations: mockStations)
}

let mockCity = Settlement(id: "65", title: "Москва", stations: mockStations)

let mockCitiesList: [Settlement] = [
    createCity("Москва"),
    createCity("Санкт-Петербург"),
    createCity("Казань"),
    createCity("Сочи"),
    createCity("Екатеринбург"),
    createCity("Омск")
]

// MARK: - Segments
func generateSegments(count: Int, startHour: Int) -> [Segment] {
    (0..<count).map { i in
        let departureHour = (startHour + i) % 24
        let arrivalHour = (departureHour + 11) % 24
        
        let departure = String(format: "%02d:05", departureHour)
        let arrival = String(format: "%02d:45", arrivalHour)
        
        return Segment(
            id: "\(i)",
            carrierName: "ОАО «РЖД»",
            carrierCode: 689,
            logo: "",
            hasTransfers: false,
            departure: departure,
            arrival: arrival,
            duration: 11 * 3600,
            date: "13 апреля"
        )
    }
}

let mockSegments = generateSegments(count: 12, startHour: 0)

// MARK: - Carrier
let mockCarrier = Carrier(title: "ОАО «РЖД»ђ", phone: "+7 (904) 329-27-71", email: "i.lozgkina@yandex.ru", logo: "")

// MARK: - Stories
let text = "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
let mockStoryGroups = StoriesMaker.makeStoriesGroups()


