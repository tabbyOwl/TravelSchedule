//
//  MainSearchViewModel.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//
import SwiftUI

@Observable
class MainSearchViewModel {
    
    // MARK: - Private Properties
    private var from: Station = Station(title: Strings.fromPlaceholder, code: "", type: "")
    private var to: Station = Station(title: Strings.toPlaceholder, code: "", type: "")
    
    // MARK: - Computed Properties
    func isSelected(title: String) -> Bool {
        title != Strings.fromPlaceholder && title != Strings.toPlaceholder
    }
    
    var fromStation: Station {
        get { from }
        set {
            if newValue.title != from.title {
                from = newValue
            }
        }
    }
    
    var toStation: Station {
        get { to }
        set {
            if newValue.title != to.title {
                to = newValue
            }
        }
    }
    
    var areCitiesSelected: Bool {
        let fromTitle = fromStation.title
        let toTitle = toStation.title
        
        return !fromTitle.isEmpty && !toTitle.isEmpty && fromTitle != Strings.fromPlaceholder && toTitle != Strings.toPlaceholder
    }
    
    // MARK: - Actions
    func swap() {
        if from.title != Strings.fromPlaceholder && to.title != Strings.fromPlaceholder {
            let temp = from
            from = to
            to = temp
        }
    }
}
