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

    private let imageDownloader = ImageDownloader()
    
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
                .environment(\.imageDownloader, imageDownloader)
        }
        .modelContainer(for: [
            SettlementEntity.self,
            StationEntity.self,
            SegmentEntity.self,
            RouteEntity.self,
            CarrierEntity.self
        ])
    }
}
