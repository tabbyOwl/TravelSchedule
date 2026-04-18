//
//  CitySearchViewModel.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//
import Foundation

@Observable
class CitySearchViewModel {
    
    // MARK: - Private Properties
    private var cities: [Settlement] = []
    private var _searchText: String = ""
    private var citiesList = mockCitiesList
    
    // MARK: - Computed Properties
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
