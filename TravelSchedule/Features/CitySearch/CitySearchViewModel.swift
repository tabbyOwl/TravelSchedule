//
//  CitySearchViewModel.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//
import Foundation
import Combine

class CitySearchViewModel: ObservableObject {
    
    @Published private var cities: [Settlement] = []
    @Published private var _searchText: String = ""
    
    private var citiesList = mockCitiesList
    
    var searchText: String {
        get { _searchText }
        set { _searchText = newValue }
    }
    
    var hasNoResults: Bool {
        !_searchText.isEmpty && filteredCities.isEmpty
    }
    
    var filteredCities: [Settlement] {
        _searchText.isEmpty ? citiesList: cities.filter { $0.title.localizedCaseInsensitiveContains(searchText)}
    }
    
    func loadCities() {
           cities = citiesList
       }
}
