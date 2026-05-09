//
//  ApiKeyBootstrap.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/5/9.
//

final class APIKeyBootstrap {

    static func setupIfNeeded() {
        let manager = APIKeyManager()

        if manager.getApiKey() == nil {
            manager.saveApiKey("39ebe8a8-df24-4caa-8c92-824abae7196d")
        }
    }
}
