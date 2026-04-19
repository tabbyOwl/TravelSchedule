//
//  NoDataView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/18.
//

import SwiftUI

struct NoDataView: View {
    
    private var text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 24, weight: .bold))
    }
}

#Preview {
    NoDataView(text: "Нет данных")
}
