//
//  Settlement.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//
import Foundation

struct Settlement: Identifiable {
    let id = UUID()
    let title: String
    let stations: [Station]
}
