//
//  StationSearchListView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/18.
//

import SwiftUI

struct StationSearchListView: View {
    
    @Binding private var station: Station
    @Binding private var isDismissing: Bool
    
    // MARK: - Environment
    @Environment(\.dismiss) private var dismiss
    
    private var stations: [Station]
    
    init(station: Binding<Station>, isDismissing: Binding<Bool>, stations: [Station]) {
        _station = station
        _isDismissing = isDismissing
        self.stations = stations
    }
    var body: some View {
        List(stations) { station in
            rowButton(text: station.title) {
                self.station = station
                isDismissing = true
                dismiss()
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
    
    private func rowButton(text: String, action: @escaping () -> Void) -> some View {
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
    StationSearchListView(station: .constant(mockStations[0]),
                          isDismissing: .constant(false),
                          stations: mockCitiesList[0].stations)
}
