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
    private var from: Station = Station(id: "8", title: Strings.MainSearch.from, code: "")
    private var to: Station = Station(id: "8", title: Strings.MainSearch.to, code: "")
    
    // MARK: - Computed Properties
    func isSelected(title: String) -> Bool {
        title != Strings.MainSearch.from && title != Strings.MainSearch.to
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
        
        return !fromTitle.isEmpty && !toTitle.isEmpty && fromTitle != Strings.MainSearch.from && toTitle != Strings.MainSearch.to
    }
    
    // MARK: - Actions
    func swap() {
        if from.title != Strings.MainSearch.to && to.title != Strings.MainSearch.from {
            let temp = from
            from = to
            to = temp
        }
    }
}
