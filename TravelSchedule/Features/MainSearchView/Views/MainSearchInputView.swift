//
//  MainSearchInputView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/18.
//

import SwiftUI

struct MainSearchInputView: View {
    
    // MARK: - Bindings
    @Binding private var viewModel: MainSearchViewModel
    
    // MARK: - Init
    init(viewModel: Binding<MainSearchViewModel>) {
        _viewModel = viewModel
    }
    
    // MARK: - Body
    var body: some View {
        
        HStack(spacing: 16) {
            inputRows
            MainSearchSwapButton(action: viewModel.swap)
        }
        .padding(.init(top: 16, leading: 16, bottom: 16, trailing: 16))
        .background(.blueUniversal)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding()
    }
    
    
    private var inputRows: some View {
        VStack {
            InputRowView(station: $viewModel.fromStation)
            InputRowView(station: $viewModel.toStation)
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    MainSearchInputView(viewModel: .constant(MainSearchViewModel()))
}
