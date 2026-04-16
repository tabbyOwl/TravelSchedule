//
//  RoutesListView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//

import SwiftUI

struct RouteListView: View {
    
    @StateObject private var viewModel: RouteListViewModel
    
    init(viewModel: RouteListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            header
            content
                .toolbarVisibility(.hidden, for: .tabBar)
        }
    }
}

private extension RouteListView {
    var header: some View {
        Text(viewModel.routeTitle)
            .padding(.leading, 16)
            .font(.system(size: 24, weight: .bold))
    }
}

private extension RouteListView {
    @ViewBuilder
    var content: some View {
        if viewModel.filteredSegments.isEmpty {
            emptyView
        } else {
            listView
        }
    }
}

private extension RouteListView {
    var emptyView: some View {
        VStack {
            Spacer()
            Text("Нет доступных маршрутов")
                .font(.system(size: 24, weight: .bold))
            Spacer()
            if viewModel.isFiltersOn {
                    filterButton
            }
        }
    }
}

private extension RouteListView {
    var listView: some View {
    ScrollView {
        ForEach(viewModel.filteredSegments) { segment in
            NavigationLink(destination: CarrierInfoView()) {
                RouteCardView(segment: segment)
                    .foregroundStyle(.blackUniversal)
            }
        }
    }
        .overlay(alignment: .bottom) {
            filterButton
        }
    }
}

private extension RouteListView {
    var filterButton: some View {
        NavigationLink(
            destination: FilterView(
                selectedIntervals: $viewModel.selectedIntervals,
                showTransfers: $viewModel.showTransfers
            )
        ) {
            filterButtonView
                .padding()
        }
    }
}

private extension RouteListView {
    var filterButtonView: some View {
            HStack {
                Text("Уточнить время")
                    .foregroundStyle(.white)
                    .font(.system(size: 17, weight: .bold))
                
                if viewModel.isFiltersOn {
                    Circle()
                        .fill(.orange)
                        .frame(width: 10, height: 10)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.blueUniversal)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }

#Preview {
    RouteListView(viewModel: RouteListViewModel(from: Station(title: "Москва", code: "", type: ""), to: Station(title: "Сочи", code: "", type: "")))
}
