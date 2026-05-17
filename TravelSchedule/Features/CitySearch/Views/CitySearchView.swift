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
        _viewModel = State(initialValue: viewModel)
    }
    
    
    // MARK: - Body
    var body: some View {
        
        Group {
            switch viewModel.state {
                
            case .loading:
                ProgressView(Strings.Common.loading)
            case .failed:
                if let errorMode = viewModel.errorMode {
                    ErrorView(mode: errorMode)
                }
            case .loaded:
                if viewModel.hasNoResults {
                    NoDataView(text: Strings.CitySearch.cityNotFound)
                } else {
                    CitySearchListView(station: $station,
                                       isDismissing: $isDismissing,
                                       cities: viewModel.filteredCities)
                }
            }
        }
        
        
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: Strings.Common.enterSearchText
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



#Preview {
    CitySearchView(station: .constant(mockStations[0]),
                   viewModel: CitySearchViewModel(repository: MockCitiesWithStationsRepository(),
                                                  stationsListService: MockStationsListService()))
}
