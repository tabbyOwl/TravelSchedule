//
//  StationEntity.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/5/3.
//

import SwiftData

@Model
final class StationEntity {
    
    @Attribute(.unique)
    var code: String
    
    var title: String
    
    init(code: String, title: String) {
        self.code = code
        self.title = title
    }
}

extension StationEntity {
    
    convenience init?(from dto: Components.Schemas.Station) {
        
        guard let code = dto.codes?.yandex_code,
              let title = dto.title
        else { return nil }
        
        self.init(code: code,title: title)
    }
}
