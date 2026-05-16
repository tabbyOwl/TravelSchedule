//
//  RoutesListView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//

import SwiftUI

struct RouteListView: View {
    
    // MARK: - State
    @State private var viewModel: RouteListViewModel
    private let carrierInfoService: CarrierInfoServiceProtocol
    
    // MARK: - Init
    init(viewModel: RouteListViewModel, carrierInfoService: CarrierInfoServiceProtocol) {
        _viewModel = State(initialValue: viewModel)
        self.carrierInfoService = carrierInfoService
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            header
            content
                .toolbarVisibility(.hidden, for: .tabBar)
                .task {
                    await viewModel.loadSchedule()
                }
                .refreshable {
                    await viewModel.refreshSchedule()
                }
        }
    }
}

// MARK: - Header
private extension RouteListView {
    var header: some View {
        Text(viewModel.routeTitle)
            .padding(.leading, 16)
            .font(.system(size: 24, weight: .bold))
    }
}

// MARK: - Content
private extension RouteListView {
    @ViewBuilder
    var content: some View {
        Spacer()
        switch viewModel.state {
            
        case .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .failed:
            if let errorMode = viewModel.errorMode {
                ErrorView(mode: errorMode)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
        case .loaded:
            ZStack(alignment: .bottom) {
                if viewModel.filteredSegments.isEmpty {
                    NoDataView(text: "Вариантов нет")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    
                    RouteSegmentsListView(segments: viewModel.filteredSegments, carrierInfoService: carrierInfoService)
                        .safeAreaInset(edge: .bottom) {
                            Color.clear.frame(height: 80)
                        }
                }
                
                FilterNavigationView(selectedIntervals: $viewModel.selectedIntervals,
                                     showTransfers: $viewModel.showTransfers,
                                     isFiltersOn: viewModel.isFiltersOn)
                
                
            }
        }
    }
}


#Preview {
    RouteListView(viewModel: RouteListViewModel(from: mockStations[0],
                                                to: mockStations[1],
                                                scheduleService: MockScheduleService(),
                                                repository: MockRouteRepository()),
                  carrierInfoService: MockCarrierInfoService())
}
