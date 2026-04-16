//
//  CitySearchView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//

import SwiftUI

struct CitySearchView: View {
    
    @Binding private var station: Station
    @StateObject private var viewModel: CitySearchViewModel
    @State private var isDismissing: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    init(station: Binding<Station>, viewModel: CitySearchViewModel) {
        _station = station
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        content
            .searchable(text: $viewModel.searchText,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Введите город")
            .onAppear {
                if isDismissing {
                    dismiss()
                }
            }
    }
    
    @ViewBuilder
    private var content: some View {
        if viewModel.hasNoResults {
            emptyView
        } else {
            listView
        }
    }
}

private extension CitySearchView {
    var emptyView: some View {
        Text("Город не найден")
            .foregroundColor(.blackUniversal)
            .font(.system(size: 24, weight: .bold))
    }
}

private extension CitySearchView {
    var listView: some View {
        List(viewModel.filteredCities) { city in
            NavigationLink(destination: StationSearchView(station: $station, viewModel: StationSearchViewModel(city: city), isDismissing: $isDismissing)) {
                Text(city.title)
            }
        }
        .listStyle(.plain)
        .navigationTitle("Выбор города")
    }
}

#Preview {
    CitySearchView(station: .constant(Station(title: "", code: "", type: "")), viewModel: CitySearchViewModel())
}
