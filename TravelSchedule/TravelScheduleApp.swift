//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/3/29.
//

import SwiftUI
import CoreData

@main
struct TravelScheduleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
