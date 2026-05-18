//
//  SegmentEntity.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/5/9.
//
import SwiftData
import Foundation

@Model
final class SegmentEntity {
    @Attribute(.unique)
    var id = UUID()
    var carrierName: String
    var carrierCode: Int
    var logo: String?
    var hasTransfers: Bool?
    var departure: String
    var arrival: String
    var duration: Int
    var date: String
    var route: RouteEntity?
    
    init(carrierName: String, carrierCode: Int, logo: String? = nil, hasTransfers: Bool, departure: String, arrival: String, duration: Int, date: String) {
        self.carrierName = carrierName
        self.carrierCode = carrierCode
        self.logo = logo
        self.hasTransfers = hasTransfers
        self.departure = departure
        self.arrival = arrival
        self.duration = duration
        self.date = date
    }
}

