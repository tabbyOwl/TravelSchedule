//
//  TabBarView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        NavigationStack {
            TabView {
                Tab("", systemImage: SystemIcons.arrowUp) {
                    MainSearchView(viewModel: MainSearchViewModel())
                }
                
                Tab("", systemImage: SystemIcons.gearshape) {
                    SettingsView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
