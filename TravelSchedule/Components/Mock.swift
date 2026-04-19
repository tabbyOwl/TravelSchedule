//
//  Mock.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//
import Foundation

let baseStations = [
    "Казанский вокзал",
    "Курский вокзал",
    "Ярославский вокзал",
    "Ленинградский вокзал"
]

// генерация городов
func createCity(_ city: String) -> Settlement {
    let stations = baseStations.map {
        Station(title: "\(city) (\($0))", code: "", type: "")
    }
    return Settlement(title: city, stations: stations)
}

let mockCitiesList: [Settlement] = [
    createCity("Москва"),
    createCity("Санкт-Петербург"),
    createCity("Казань"),
    createCity("Сочи"),
    createCity("Екатеринбург"),
    createCity("Омск")
]

func generateSegments(count: Int, startHour: Int) -> [Segment] {
    (0..<count).map { i in
        let departureHour = startHour + i
        let arrivalHour = (departureHour + 11) % 24
        
        let departure = String(format: "%02d:05", departureHour)
        let arrival = String(format: "%02d:45", arrivalHour)
        
        return Segment(
            carrierName: "Российские железные дороги",
            carrierCode: 689,
            logo: "",
            hasTransfers: false,
            departure: departure,
            arrival: arrival,
            duration: "11 часов",
            date: "13 апреля"
        )
    }
}

let mockSegments = generateSegments(count: 12, startHour: 0)
