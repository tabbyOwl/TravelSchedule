//
//  WebView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/25.
//

import SwiftUI
import WebKit

// 1. Создаем WebView, используя UIViewRepresentable
struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        // Создаем WKWebView
        let webView = WKWebView()
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Загружаем URL в webView
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    
}
