//
//  MainSearchInputView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/18.
//
import SwiftData
import SwiftUI

struct MainSearchInputView: View {
    
    @Environment(\.modelContext) private var modelContext
    @State private var citySearchViewModel: CitySearchViewModel?
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
        
        .task {
            guard citySearchViewModel == nil else {
                return
            }
            
            let factory = DefaultServiceFactory()
            
            let repository = CitiesRepository(
                modelContainer: modelContext.container
            )
            
            citySearchViewModel = CitySearchViewModel(
                repository: repository,
                stationsListService: factory.stationsListService,
                nearestStationsService: factory.nearestStationsService
            )
        }
    }
    
    
    private var inputRows: some View {
        VStack {
            if let citySearchViewModel {
                InputRowView(station: $viewModel.fromStation, citySearchViewModel: citySearchViewModel)
                InputRowView(station: $viewModel.toStation, citySearchViewModel: citySearchViewModel)
            }
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    MainSearchInputView(viewModel: .constant(MainSearchViewModel()))
}
