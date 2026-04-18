//
//  MainSearchSwapButton.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/18.
//

import SwiftUI

struct MainSearchSwapButton: View {
    private var action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Image(.change)
                .frame(width: 36, height: 36)
                .background(.white)
                .clipShape(.circle)
        }
    }
}
