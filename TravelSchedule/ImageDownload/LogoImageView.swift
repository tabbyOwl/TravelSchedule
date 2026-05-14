//
//  RemoteImageView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/5/12.
//
import SwiftUI

struct LogoImageView: View {
    
    @Environment(\.imageDownloader) private var imageDownloader
    
    let url: String?
    
    @State private var image: UIImage?
    
    var body: some View {
        Group {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Image("CarrierLogo")
                    .resizable()
                    .scaledToFit()
                    .padding(8)
                    .foregroundStyle(.gray)
            }
        }
        .task(id: url) {
            image = nil
            
            guard let url else { return }
            
            let downloadedImage = await imageDownloader.downloadImage(from: url)
            
            if self.url == url {
                image = downloadedImage
            }
        }
    }
}
