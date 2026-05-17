//
//  RouteSegmentsListView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/18.
//
import SwiftData
import SwiftUI

struct RouteSegmentsListView: View {
    
    // MARK: - Environment
    @Environment(\.modelContext) private var modelContext
    
    // MARK: - Private Properties
    private var segments: [Segment]
    private let carrierInfoService: CarrierInfoServiceProtocol
    
    // MARK: - Init
    init(segments: [Segment], carrierInfoService: CarrierInfoServiceProtocol) {
        self.segments = segments
        self.carrierInfoService = carrierInfoService
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            ForEach(segments) { segment in
                NavigationLink(destination: CarrierInfoView(viewModel: makeCarrierInfoViewModel(with: String(segment.carrierCode)))) {
                    RouteCardCell(segment: segment)
                        .foregroundStyle(.blackUniversal)
                }
            }
        }
    }
    
    private func makeCarrierInfoViewModel(with code: String) -> CarrierInfoViewModel {
        let repository = CarrierInfoRepository(modelContainer: modelContext.container)
        return CarrierInfoViewModel(code: code, service: carrierInfoService, repository: repository)
        
    }
}

#Preview {
    RouteSegmentsListView(segments: mockSegments,
                          carrierInfoService: MockCarrierInfoService())
}
