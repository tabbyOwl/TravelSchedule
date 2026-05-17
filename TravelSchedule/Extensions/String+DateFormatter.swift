//
//  String+DateFormatter.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/5/16.
//
import Foundation

extension String {
    
    func formattedRussianDate() -> String {
        guard let date = DateFormatter.apiDateFormatter.date(from: self) else {
            return self
        }
        
        return DateFormatter.russianDateFormatter.string(from: date)
    }
}
