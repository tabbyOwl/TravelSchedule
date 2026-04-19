//
//  InputRowView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//
import SwiftUI

struct InputRowView: View {
    // MARK: - Bindings
    @Binding var station: Station
    
    // MARK: - Init
    init(station: Binding<Station>) {
        _station = station
    }
    
    // MARK: - Body
    var body: some View {
        let title = station.title
        let isSelected = title != Strings.fromPlaceholder && title != Strings.toPlaceholder
        
        NavigationLink(destination: CitySearchView(station: $station, viewModel: CitySearchViewModel())) {
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
