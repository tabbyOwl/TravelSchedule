//
//  RouteCardBottomView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/18.
//

import SwiftUI

struct RouteCardBottomView: View {
    // MARK: - Private Properties
    private var departure: String
    private var duration: String
    private var arrival: String
    
    // MARK: - Init
    init(departure: String, duration: String, arrival: String) {
        self.departure = departure
        self.duration = duration
        self.arrival = arrival
    }
    
    // MARK: - Body
    var body: some View {
        HStack {
            Text(departure)
                .fixedSize(horizontal: true, vertical: false)
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color.grayUniversal)
            
            Text(duration)
                .fixedSize(horizontal: true, vertical: false)
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color.grayUniversal)
            Text(arrival)
                .fixedSize(horizontal: true, vertical: false)
        }
        .font(.system(size: 17, weight: .regular))
        .padding(4)
    }
}

#Preview {
    RouteCardBottomView(departure: "13:05", duration: "5 часов", arrival: "18:05")
}
