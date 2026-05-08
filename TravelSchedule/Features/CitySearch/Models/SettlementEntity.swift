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
    var stations: [StationEntity]

    init(id: String, title: String, stations: [StationEntity]) {
        self.id = id
        self.title = title
        self.stations = stations
    }
}

extension SettlementEntity {

    convenience init?(from dto: Components.Schemas.Settlement) {

        guard let id = dto.codes?.yandex_code,
              let title = dto.title,
              let stationsDTO = dto.stations
        else { return nil }

        let stations = stationsDTO.compactMap {
            StationEntity(from: $0)
        }

        self.init(
            id: id,
            title: title,
            stations: stations
        )
    }
}
