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
    
    // MARK: - Init
    init(viewModel: RouteListViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            header
            content
                .toolbarVisibility(.hidden, for: .tabBar)
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
        if viewModel.filteredSegments.isEmpty {
            VStack{
                Spacer()
                NoDataView(text: "Вариантов нет")
                Spacer()
                if viewModel.isFiltersOn {
                    FilterNavigationView(selectedIntervals: $viewModel.selectedIntervals,
                                         showTransfers: $viewModel.showTransfers,
                                         isFiltersOn: viewModel.isFiltersOn)
                }
            }
            
        } else {
            ZStack(alignment: .bottom) {
                RouteSegmentsListView(segments: viewModel.filteredSegments)
                
                FilterNavigationView(selectedIntervals: $viewModel.selectedIntervals, showTransfers: $viewModel.showTransfers, isFiltersOn: viewModel.isFiltersOn)
            }
        }
    }
}

#Preview {
    RouteListView(viewModel: RouteListViewModel(from: mockStation, to: mockStation))
}
