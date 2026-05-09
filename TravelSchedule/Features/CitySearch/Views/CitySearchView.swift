//
//  CitySearchView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//

import SwiftUI
import SwiftData

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
        _viewModel = State(initialValue: viewModel)
    }
    
    
    // MARK: - Body
    var body: some View {
        
        Group {
            if let errorMode = viewModel.errorMode {
                ErrorView(mode: errorMode)
            } else if viewModel.shouldShowSearchLoading {
                ProgressView()
            }
            else if viewModel.hasNoResults {
                NoDataView(text: "Город не найден")
            } else {
                CitySearchListView(station: $station,
                                   isDismissing: $isDismissing,
                                   cities: viewModel.filteredCities)
            }
        }
                
                .searchable(
                    text: $viewModel.searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Введите запрос"
                )
        .toolbarVisibility(.hidden, for: .tabBar)
    
        .task {
            await viewModel.loadCities()
        }
        .onChange(of: isDismissing) { _, newValue in
            if newValue {
                dismiss()
            }
        }
    }
}

//#Preview {
//
//    CitySearchView(
//        station: .constant(mockStation),
//        viewModel: .mock
//    )
//}
//
//extension CitySearchViewModel {
//
//    static let mock = CitySearchViewModel(
//        repository: MockRepository(),
//        stationsListService: MockStationsListService(),
//        nearestStationsService: MockNearestStationsService()
//    )
//}
