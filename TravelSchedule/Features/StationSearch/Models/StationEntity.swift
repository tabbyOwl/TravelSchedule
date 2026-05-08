//
//  StationEntity.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/5/3.
//

import SwiftData

@Model
final class StationEntity {

    var code: String
    var title: String

    init(
        code: String,
        title: String
    ) {
        self.code = code
        self.title = title
    }
}

extension StationEntity {

    convenience init?(from dto: Components.Schemas.Station) {

        guard let code = dto.code,
              let title = dto.title
        else { return nil }

        self.init(
            code: code,
            title: title
        )
    }
}
