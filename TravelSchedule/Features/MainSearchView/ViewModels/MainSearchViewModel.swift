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
    private var from: Station = Station(id: "8", title: MainSearchStrings.fromPlaceholder, code: "")
    private var to: Station = Station(id: "8", title: MainSearchStrings.toPlaceholder, code: "")
    
    // MARK: - Computed Properties
    func isSelected(title: String) -> Bool {
        title != MainSearchStrings.fromPlaceholder && title != MainSearchStrings.toPlaceholder
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
        
        return !fromTitle.isEmpty && !toTitle.isEmpty && fromTitle != MainSearchStrings.fromPlaceholder && toTitle != MainSearchStrings.toPlaceholder
    }
    
    // MARK: - Actions
    func swap() {
        if from.title != MainSearchStrings.fromPlaceholder && to.title != MainSearchStrings.fromPlaceholder {
            let temp = from
            from = to
            to = temp
        }
    }
}
