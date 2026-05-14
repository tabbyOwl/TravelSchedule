//
//  CarrierEntity.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/5/14.
//
import SwiftData

@Model
final class CarrierEntity {
    @Attribute(.unique)
    var code: String
    var title: String
    var phone: String?
    var email: String?
    var logo: String?
    
    init(code: String, title: String, phone: String?, email: String?, logo: String?) {
        self.code = code
        self.title = title
        self.phone = phone
        self.email = email
        self.logo = logo
    }
}
