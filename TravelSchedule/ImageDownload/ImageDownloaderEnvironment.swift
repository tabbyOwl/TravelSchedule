//
//  ImageDownloaderEnvironment.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/5/12.
//

import SwiftUI

private struct ImageDownloaderKey: EnvironmentKey {
    static let defaultValue = ImageDownloader()
}

extension EnvironmentValues {
    
    var imageDownloader: ImageDownloader {
        
        get { self[ImageDownloaderKey.self] }
        
        set { self[ImageDownloaderKey.self] = newValue }
    }
}
