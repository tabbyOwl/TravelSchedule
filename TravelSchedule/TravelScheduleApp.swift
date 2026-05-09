//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/3/29.
//

import SwiftUI
import KeychainSwift
import SwiftData
import OpenAPIURLSession

@main
struct TravelScheduleApp: App {

    @AppStorage("isDarkMode") private var isDarkMode = false

    private let factory: ServiceFactory

    init() {
        APIKeyBootstrap.setupIfNeeded()
        do {
            self.factory = try AppAssembly.makeFactory()
        } catch {
            fatalError("App init failed: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            let viewModel = MainSearchViewModel()
            TabBarView(factory: factory, viewModel: viewModel)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
        .modelContainer(for: [
            SettlementEntity.self,
            StationEntity.self
        ])
    }
}
