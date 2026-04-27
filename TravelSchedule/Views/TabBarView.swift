//
//  TabBarView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            Tab("", systemImage: "arrow.up.message.fill") {
                MainSearchView(viewModel: MainSearchViewModel())
            }
            
            Tab("", systemImage: "gearshape") {
                SettingsView()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
