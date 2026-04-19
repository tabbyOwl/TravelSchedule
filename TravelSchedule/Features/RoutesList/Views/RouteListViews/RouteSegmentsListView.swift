//
//  RouteSegmentsListView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/18.
//

import SwiftUI

struct RouteSegmentsListView: View {
    // MARK: - Private Properties
    private var segments: [Segment]
    
    // MARK: - Init
    init(segments: [Segment]) {
        self.segments = segments
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            ForEach(segments) { segment in
                NavigationLink(destination: CarrierInfoView()) {
                    RouteCardView(segment: segment)
                        .foregroundStyle(.blackUniversal)
                }
            }
        }
    }
}

#Preview {
    RouteSegmentsListView(segments: [])
}
