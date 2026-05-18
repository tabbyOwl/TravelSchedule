//
//  SettlementEntity.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/5/3.
//

import SwiftData

@Model
final class SettlementEntity {
    
    @Attribute(.unique)
    var id: String
    var title: String
    
    var stations: [StationEntity] = []
    
    init(id: String, title: String, stations: [StationEntity]) {
        self.id = id
        self.title = title
        self.stations = stations
    }
}

