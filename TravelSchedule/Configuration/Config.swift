//
//  Config.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/5/18.
//
import Foundation

enum Config {

    static let apiKey: String = {
        guard let key = Bundle.main.object(
            forInfoDictionaryKey: "API_KEY"
        ) as? String else {
            fatalError("API_KEY not found")
        }

        return key
    }()
}
