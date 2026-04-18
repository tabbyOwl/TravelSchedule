//
//  MainSearchView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//

import SwiftUI

struct MainSearchView: View {
    
    // MARK: - State
    @State private var viewModel = MainSearchViewModel()
    
    // MARK: - Init
    init(viewModel: MainSearchViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            content
            if viewModel.areCitiesSelected {
                MainSearchSearchButton(fromStation: viewModel.fromStation, toStation: viewModel.toStation)
            }
        }
    }

    // MARK: - Content
    private var content: some View {
        HStack {
            MainSearchInputView(fromStation: $viewModel.fromStation, toStation: $viewModel.toStation)
            MainSearchSwapButton(action: viewModel.swap)
        }
        .padding()
        .background(.blueUniversal)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    MainSearchView(viewModel: MainSearchViewModel())
}
