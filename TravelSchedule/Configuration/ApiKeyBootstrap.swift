//
//  ApiKeyBootstrap.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/5/9.
//

final class APIKeyBootstrap {

    static func setupIfNeeded() {
        let manager = APIKeyManager()

        guard manager.getApiKey() == nil else {
            return
        }

        manager.saveApiKey(Config.apiKey)
    }
}


