//
//  CloseButton.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/21.
//

import SwiftUI

struct CloseButton: View {
    let action: () -> Void

    var body: some View {
        Button("", image: .close) {
            action()
        }
    }
}
