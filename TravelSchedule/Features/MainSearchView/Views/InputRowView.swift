//
//  InputRowView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//
import SwiftUI
import SwiftData

struct InputRowView: View {
    
    // MARK: - Bindings
    @Binding var station: Station
    
    let citySearchViewModel: CitySearchViewModel
    // MARK: - Init
    init(station: Binding<Station>, citySearchViewModel: CitySearchViewModel) {
        _station = station
        self.citySearchViewModel = citySearchViewModel
    }
    
    // MARK: - Body
    var body: some View {
        let title = station.title
        let isSelected = title != Strings.fromPlaceholder && title != Strings.toPlaceholder
        
        NavigationLink(destination: CitySearchView(station: $station,
                                                   viewModel: citySearchViewModel)) {
            rowView(title: title, isSelected: isSelected)
        }
    }
    
    // MARK: - Row
    func rowView(title: String, isSelected: Bool) -> some View {
        return Text(title)
            .foregroundStyle(isSelected ? .blackUniversal : .grayUniversal)
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(1)
            .padding()
    }
}
