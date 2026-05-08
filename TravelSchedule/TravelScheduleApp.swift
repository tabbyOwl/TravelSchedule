//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/3/29.
//

import SwiftUI
import KeychainSwift
import SwiftData

@main
struct TravelScheduleApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    let persistenceController = PersistenceController.shared
    let apiKeyManager = APIKeyManager()
    
    init() {
        apiKeyManager.saveApiKey("39ebe8a8-df24-4caa-8c92-824abae7196d")
    }
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .modelContainer(for: [
            SettlementEntity.self,
            StationEntity.self
        ])
    }
}
