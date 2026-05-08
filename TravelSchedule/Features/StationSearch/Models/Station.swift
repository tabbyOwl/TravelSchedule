//
//  Station.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//
import Foundation

struct Station: Identifiable, Codable {
    let id: UUID
    let title: String
    let code: String
}

extension Station {
   nonisolated init?(from dto: Components.Schemas.Station) {
        
        guard let code = dto.codes?.yandex_code,
              let type = dto.station_type,
              let title = dto.title else { return nil }

        self.id = UUID()
        self.code = code
        self.title = title
    }
}
