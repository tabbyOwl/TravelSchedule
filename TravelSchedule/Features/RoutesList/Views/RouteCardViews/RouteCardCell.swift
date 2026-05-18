//
//  RouteCardView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//
import SwiftUI

struct RouteCardCell: View {
    
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
                             date: segment.formattedDate,
                             logo: segment.logo)
            
            RouteCardBottomView(departure: segment.departure,
                                duration: segment.formattedDuration,
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
        RouteCardCell(segment: mockSegments[0])
    }
    .foregroundStyle(.blackUniversal)
}
