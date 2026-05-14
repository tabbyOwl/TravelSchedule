//
//  Carrier.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/20.
//

struct Carrier: Codable {
    let title: String
    let phone: String?
    let email: String?
    let logo: String?
    
    static let empty = Carrier(
        title: "",
        phone: nil,
        email: nil,
        logo: nil
    )
}
