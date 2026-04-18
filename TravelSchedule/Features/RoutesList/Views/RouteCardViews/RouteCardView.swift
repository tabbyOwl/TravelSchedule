//
//  RouteCardView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//
import SwiftUI

struct RouteCardView: View {
    
    // MARK: - Private Properties
    private let segment: Segment
    
    // MARK: - Init
    init(segment: Segment) {
        self.segment = segment
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            RouteCardTopView(carrierName: segment.carrierName,
                             hasTransfers: segment.hasTransfers,
                             date: segment.date)
            
            RouteCardBottomView(departure: segment.departure,
                                duration: segment.duration,
                                arrival: segment.arrival)
        }
        .padding()
        .background(.lightGrayUniversal)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .padding(.leading)
        .padding(.trailing)
    }
}

#Preview {
    NavigationLink(destination: EmptyView()) {
        RouteCardView(segment: Segment(carrierName: "Российские Железные Дороги", carrierCode: 45, logo: "", hasTransfers: true, departure: "13:05", arrival: "12:45", duration: "9 часов", date: "12 апреля"))
    }.foregroundStyle(.blackUniversal)
}
