//
//  MainSearchInputView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/18.
//
import SwiftData
import SwiftUI

struct MainSearchInputView: View {
    
    private var citySearchViewModel: CitySearchViewModel
    // MARK: - Bindings
    @Binding private var viewModel: MainSearchViewModel
    
    // MARK: - Init
    init(viewModel: Binding<MainSearchViewModel>, citySearchViewModel: CitySearchViewModel) {
        _viewModel = viewModel
        self.citySearchViewModel = citySearchViewModel
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
                InputRowView(station: $viewModel.fromStation, citySearchViewModel: citySearchViewModel)
                InputRowView(station: $viewModel.toStation, citySearchViewModel: citySearchViewModel)
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

//#Preview {
//    MainSearchInputView(viewModel: .constant(MainSearchViewModel()))
//}
