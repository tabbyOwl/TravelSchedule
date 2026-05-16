//
//  TermsView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/25.
//

import SwiftUI

struct TermsView: View {
    private let url = Terms.termsURL
    
    var body: some View {
        Group {
            if let url = url {
                WebView(url: url)
                    
            } else {
                Text(TermsViewStrings.invalidUrl)
            }
        }
        .ignoresSafeArea()
        .navigationTitle(TermsViewStrings.title)
        .toolbarVisibility(.hidden, for: .tabBar)
        .toolbarBackground(.white, for: .navigationBar)
        
    }
}

#Preview {
    TermsView()
}
