//
//  StationSearchViewModel.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//
import Foundation

@Observable
class StationSearchViewModel {
    
    var searchText: String = ""
    private var stations: [Station]
    private(set) var isLoading: Bool = false
    
    init(stations: [Station]) {
        self.stations = stations
    }
    
    var hasNoResults: Bool {
        !searchText.isEmpty && filteredStations.isEmpty
    }
    
    var filteredStations: [Station] {
       return searchText.isEmpty ? stations : stations.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }
}
