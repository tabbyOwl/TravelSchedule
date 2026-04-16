//
//  Station.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//

import Foundation

struct Station: Identifiable {
    let id = UUID()
    let title: String
    let code: String
    let type: String
}
