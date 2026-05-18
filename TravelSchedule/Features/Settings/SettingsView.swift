//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        
        NavigationStack {
            Toggle(Strings.Settings.darkMode, isOn: $isDarkMode)
                .tint(.blueUniversal)
                .frame(width: 375, height: 60)
            
            NavigationLink(destination: TermsView()) {
                HStack {
                    Text(Strings.Terms.terms)
                    Spacer()
                    Image(systemName: SystemIcons.chevronRight)
                }
            }
            .frame(width: 375, height: 60)
            Spacer()
            
            VStack(spacing: 16) {
                Text(Strings.Settings.appUsesYandexAPI)
                Text(Strings.Settings.version)
            }
            .padding(.bottom, 24)
            .font(.system(size: 12))
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .foregroundStyle(.primary)
    }
}

#Preview {
    SettingsView()
}
