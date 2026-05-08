//
//  APIKeyManager.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/5/2.
//

import KeychainSwift

final class APIKeyManager {
    private let keychain = KeychainSwift()
    
    func saveApiKey(_ apiKey: String) {
        keychain.set(apiKey, forKey: "API_KEY")
    }

    func getApiKey() -> String? {
        return keychain.get("API_KEY")
    }

    func deleteApiKey() {
        keychain.delete("API_KEY")
    }
}
