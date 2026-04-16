//
//  InputRowView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//
import SwiftUI

struct InputRowView: View {
    @Binding var station: Station
    
    init(station: Binding<Station>) {
        _station = station
    }
    
    var body: some View {
        let title = station.title
        
        NavigationLink(destination: CitySearchView(station: $station, viewModel: CitySearchViewModel())) {
            rowView(title: title, isSelected: title != Strings.fromPlaceholder && title != Strings.toPlaceholder)
        }
    }
}

private extension InputRowView {
    func rowView(title: String, isSelected: Bool) -> some View {
        return Text(title)
            .foregroundStyle(isSelected ? .blackUniversal : .grayUniversal)
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(1)
            .padding()
    }
}
