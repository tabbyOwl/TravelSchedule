//
//  CitySearchView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//

import SwiftUI

struct CitySearchView: View {
    
    // MARK: - Bindings
    @Binding private var station: Station
    
    // MARK: - State
    @State private var viewModel: CitySearchViewModel
    @State private var isDismissing: Bool = false
    
    // MARK: - Environment
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Init
    init(station: Binding<Station>, viewModel: CitySearchViewModel) {
        _station = station
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    var body: some View {
        content
            .searchable(text: $viewModel.searchText,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Введите запрос")

            .onAppear {
                if isDismissing {
                    dismiss()
                }
                viewModel.loadCities()
            }
            .toolbarVisibility(.hidden, for: .tabBar)
    }
    
    // MARK: - Content
    @ViewBuilder
    private var content: some View {
        if viewModel.hasNoResults {
            NoDataView(text: "Город не найден")
        } else {
            CitySearchListView(station: $station, isDismissing: $isDismissing, cities: viewModel.filteredCities)
        }
    }
}

#Preview {
    CitySearchView(station: .constant(Station(title: "", code: "", type: "")), viewModel: CitySearchViewModel())
}
