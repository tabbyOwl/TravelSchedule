//
//  Segment.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//
import Foundation

struct Segment: Identifiable {
    let id = UUID()
    let carrierName: String
    let carrierCode: Int
    let logo: String?
    let hasTransfers: Bool
    let departure: String
    let arrival: String
    let duration: String
    let date: String
}
