//
//  TermsView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/25.
//

import SwiftUI

struct TermsView: View {
    private let url = URL(string: TermsViewStrings.url)
    
    var body: some View {
        Group {
            if let url {
                WebView(url: url)
                    
            } else {
                Text(TermsViewStrings.uncorrectUrl)
            }
        }
        .ignoresSafeArea()
        .navigationTitle(TermsViewStrings.title)
        .toolbarVisibility(.hidden, for: .tabBar)
        
    }
}

#Preview {
    TermsView()
}
