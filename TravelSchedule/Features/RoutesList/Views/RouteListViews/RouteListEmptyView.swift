//
//  RouteListEmptyView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/18.
//

import SwiftUI

struct RouteListEmptyView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Нет доступных маршрутов")
                .font(.system(size: 24, weight: .bold))
            Spacer()
            
        }
    }
}

#Preview {
    RouteListEmptyView()
}
