//
//  MainSearchSearchButton.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/18.
//

import SwiftUI

struct MainSearchSearchButton: View {
    
    // MARK: - Private Properties
    private var fromStation: Station
    private var toStation: Station
    
    // MARK: - Init
    init(fromStation: Station, toStation: Station) {
        self.fromStation = fromStation
        self.toStation = toStation
    }
    
    // MARK: - Body
    var body: some View {
        NavigationLink(destination: RouteListView(viewModel: RouteListViewModel(from: fromStation, to: toStation))) {
            Text("Найти")
                .foregroundStyle(.white)
                .font(.system(size: 17, weight: .bold))
        }
        .padding()
        .frame(width: MainSearchLayout.searchButtonWidth)
        .background(.blueUniversal)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
