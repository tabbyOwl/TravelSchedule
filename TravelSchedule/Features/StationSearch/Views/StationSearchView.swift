//
//  StationSearchView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//

import SwiftUI

struct StationSearchView: View {
    
    // MARK: - Bindings
    @Binding private var station: Station
    @Binding private var isDismissing: Bool
    
    // MARK: - State
    @State private var viewModel: StationSearchViewModel
    
    // MARK: - Init
    init(station: Binding<Station>, isDismissing: Binding<Bool>, viewModel: StationSearchViewModel) {
        _station = station
        _isDismissing = isDismissing
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    var body: some View {
        content
            .searchable(text: $viewModel.searchText,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Введите запрос")
    }
    
    // MARK: - Content
    @ViewBuilder
    var content: some View {
            if viewModel.hasNoResults {
                NoDataView(text: "Станция не найдена")
            } else {
                StationSearchListView(station: $station,
                                      isDismissing: $isDismissing,
                                      stations: viewModel.filteredStations)
                    .navigationTitle("Выбор станции")
            }
        }
    }


#Preview {
    NavigationStack {
        StationSearchView(station: .constant(mockStations[0]),
                          isDismissing: .constant(false),
                          viewModel: StationSearchViewModel(stations: mockStations))
    }
}

