//
//  ImageDownloader.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/5/12.
//

import SwiftUI
import Logging

actor ImageDownloader {
    private let logger = Logger(label: "ImageDownloader")
    private var cache: [String: UIImage] = [:]
    private var activeDownloads: [String: Task<UIImage?, Never>] = [:]

    func downloadImage(from url: String) async -> UIImage? {
        if let cachedImage = cache[url] {
            return cachedImage
        }

        if let existingDownload = activeDownloads[url] {
            return await existingDownload.value
        }

        let downloadTask = Task<UIImage?, Never> { [weak self] in
            return await self?.fetchImage(from: url)
        }

        activeDownloads[url] = downloadTask

        let image = await downloadTask.value
        if let image = image {
            cache[url] = image
        }
        activeDownloads.removeValue(forKey: url)
        return image
    }
    
    private func fetchImage(from urlString: String) async -> UIImage? {
            guard let url = URL(string: urlString) else {
                return nil
            }

            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                guard let httpResponse = response as? HTTPURLResponse,
                      200...299 ~= httpResponse.statusCode else {
                    return nil
                }

                return UIImage(data: data)
            } catch {
                logger.info("Image download error:", error: error)
                return nil
            }
        }
}
