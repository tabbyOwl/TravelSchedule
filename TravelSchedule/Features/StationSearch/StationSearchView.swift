//
//  StationSearchView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//

import SwiftUI

struct StationSearchView: View {
    
    @Binding private var station: Station
    @Binding private var isDismissing: Bool
    @StateObject private var viewModel: StationSearchViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(station: Binding<Station>, viewModel: StationSearchViewModel, isDismissing: Binding<Bool>) {
        _station = station
        _viewModel = StateObject(wrappedValue: viewModel)
        _isDismissing = isDismissing
    }
    
    var body: some View {
        content
            .searchable(text: $viewModel.searchText,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Введите станцию")
    }
}
    
private extension StationSearchView {
    @ViewBuilder
    var content: some View {
        if viewModel.isLoading {
            loadingView
        } else {
            if viewModel.hasNoResults {
                emptyView
            } else {
                listView
                    .navigationTitle("Выбор станции")
            }
        }
    }
}

private extension StationSearchView {
    var emptyView: some View {
        Text("Станция не найдена")
            .foregroundColor(.blackUniversal)
            .font(.system(size: 24, weight: .bold))
    }
}

private extension StationSearchView {
    var loadingView: some View {
        VStack {
            Spacer()
            ProgressView("Загрузка...")
                .progressViewStyle(CircularProgressViewStyle())
                .padding()
            Spacer()
        }
    }
}

private extension StationSearchView {
    var listView: some View {
        List(viewModel.filteredStations) { station in
            rowButton(text: station.title) {
                    self.station = station
                    isDismissing = true
                    dismiss()
                }
            }
    }
}

private extension StationSearchView {
    
    func rowButton(text: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(text)
                Spacer()
                Image(systemName: SystemIcons.chevronRight)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}


    #Preview {
        NavigationStack {
            StationSearchView(station: .constant(Station(title: "", code: "", type: "")), viewModel: StationSearchViewModel(city: Settlement(title: "", stations: [])), isDismissing: .constant(false))
        }
    }

