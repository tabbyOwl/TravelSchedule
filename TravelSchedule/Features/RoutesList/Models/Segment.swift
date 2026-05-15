//
//  Segment.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//
import Foundation

struct Segment: Identifiable, Sendable {
    let id: String
    let carrierName: String
    let carrierCode: Int
    let logo: String?
    let hasTransfers: Bool
    let departure: String
    let arrival: String
    let duration: Int
    let date: String
    
    var formattedDuration: String {
        let totalHours = duration / 3600
        
        let days = totalHours / 24
        let hours = totalHours % 24
        
        if days > 0 {
            return "\(days) д \(hours) ч"
        } else {
            return "\(hours) часов"
        }
    }
}
