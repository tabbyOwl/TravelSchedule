//
//  TabBarView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//

import SwiftUI

struct TabBarView: View {
    
    private let factory: ServiceFactory
    private let viewModel: MainSearchViewModel
    
    init(factory: ServiceFactory, viewModel: MainSearchViewModel) {
        self.factory = factory
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            TabView {
                Tab("", systemImage: SystemIcons.arrowUp) {
                    
                    let viewModel = MainSearchViewModel()
                    MainSearchView(viewModel: viewModel, factory: factory)
                }
                
                Tab("", systemImage: SystemIcons.gearshape) {
                    SettingsView()
                }
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBarView(factory: ServiceFactory())
//    }
//}
