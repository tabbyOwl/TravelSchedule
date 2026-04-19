//
//  CitySearchListView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/18.
//

import SwiftUI

struct CitySearchListView: View {
    
    // MARK: - Bindings
    @Binding private var station: Station
    @Binding private var isDismissing: Bool
    
    // MARK: - Private Properties
    private var cities: [Settlement]
   
    // MARK: - Init
    init(station: Binding<Station>, isDismissing: Binding<Bool>, cities: [Settlement]) {
        _station = station
        _isDismissing = isDismissing
        self.cities = cities
    }
    
    // MARK: - Body
    var body: some View {
        List(cities) { city in
            NavigationLink { StationSearchView(station: $station, isDismissing: $isDismissing, viewModel: StationSearchViewModel(city: city)) } label: {
                HStack {
                    Text(city.title)
                    Spacer()
                    Image(systemName: SystemIcons.chevronRight)
                }
            }
            .navigationLinkIndicatorVisibility(.hidden)
            .listRowSeparator(.hidden)
            .tint(.black)
        }
        .listStyle(.plain)
        .navigationTitle("Выбор города")
    }
}

#Preview {
    CitySearchView(station: .constant(Station(title: "", code: "", type: "")), viewModel: CitySearchViewModel())
}
