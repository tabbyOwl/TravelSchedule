//
//  StationSearchViewModel.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//
import Combine
import Foundation

class StationSearchViewModel: ObservableObject {
    
    @Published private var city: Settlement
    @Published private var _isLoading: Bool = false
    @Published private var _searchText: String = ""
    
    init(city: Settlement) {
        self.city = city
    }
    
    var searchText: String {
        get { _searchText }
        set { _searchText = newValue }
    }
    
    var isLoading: Bool {
        _isLoading
    }
    
    var hasNoResults: Bool {
        !_searchText.isEmpty && filteredStations.isEmpty
    }
    
    var filteredStations: [Station] {
        _searchText.isEmpty ? city.stations : city.stations.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }
}
