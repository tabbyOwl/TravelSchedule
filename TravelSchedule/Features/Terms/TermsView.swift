//
//  TermsView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/25.
//

import SwiftUI

struct TermsView: View {
    private let url = URL(string: TermsViewStrings.url)
    
    init() {
            //Use this if NavigationBarTitle is with Large Font
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.red]

            //Use this if NavigationBarTitle is with displayMode = .inline
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.red]
        }
    
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
        .toolbarBackground(.white, for: .navigationBar)
        
    }
}

#Preview {
    TermsView()
}
