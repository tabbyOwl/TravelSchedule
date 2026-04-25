//
//  TermsView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/25.
//

import SwiftUI

struct TermsView: View {
    private let url = URL(string: "https://yandex.ru/legal/timetable_termsofuse/ru/")
    
    var body: some View {
        Group {
            if let url {
                WebView(url: url)
            } else {
                Text("Некорректный URL")
            }
        }
        .ignoresSafeArea()
        .navigationTitle("Пользовательское соглашение")
        .toolbarVisibility(.hidden, for: .tabBar)
    }
}

#Preview {
    TermsView()
}
