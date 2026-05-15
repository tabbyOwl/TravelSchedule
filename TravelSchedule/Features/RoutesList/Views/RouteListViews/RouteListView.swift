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
    private let factory: ServiceFactoryProtocol
    
    // MARK: - Init
    init(viewModel: RouteListViewModel, factory: ServiceFactoryProtocol) {
        _viewModel = State(initialValue: viewModel)
        self.factory = factory
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
            if viewModel.filteredSegments.isEmpty {
                NoDataView(text: "Вариантов нет")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ZStack(alignment: .bottom) {
                    RouteSegmentsListView(segments: viewModel.filteredSegments, factory: factory)
                        .safeAreaInset(edge: .bottom) {
                            Color.clear.frame(height: 80)
                        }
                }
                FilterNavigationView(selectedIntervals: $viewModel.selectedIntervals, showTransfers: $viewModel.showTransfers, isFiltersOn: viewModel.isFiltersOn)
            }
        
        if viewModel.isFiltersOn {
            FilterNavigationView(selectedIntervals: $viewModel.selectedIntervals,
                                 showTransfers: $viewModel.showTransfers,
                                 isFiltersOn: viewModel.isFiltersOn)
            
        }
    }
}
}

//#Preview {
//    RouteListView(viewModel: RouteListViewModel(from: mockStation, to: mockStation))
//}
