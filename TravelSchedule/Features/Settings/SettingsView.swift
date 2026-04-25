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
            Toggle("Темная тема", isOn: $isDarkMode)
                .tint(.blueUniversal)
                .frame(width: 375, height: 60)
               
            NavigationLink(destination: CopyrightView()) {
                HStack {
                    Text("Пользовательское соглашение")
                    Spacer()
                    Image(systemName: SystemIcons.chevronRight)
                }
               
            }
            .frame(width: 375, height: 60)
            Spacer()
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .foregroundStyle(.primary)
        VStack(spacing: 16) {
            Text("Приложение использует API «Яндекс.Расписания»")
            Text("Версия 1.0 (beta)")
        }
        .padding(.bottom, 24)
        .font(.system(size: 12))
    }
    
}

#Preview {
    SettingsView()
}
