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
    private let factory: ServiceFactoryProtocol
    
    // MARK: - Init
    init(segments: [Segment], factory: ServiceFactoryProtocol) {
        self.segments = segments
        self.factory = factory
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
            let service = factory.makeCarrierInfoService()
            let repository = CarrierInfoRepository(modelContainer: modelContext.container)
            return CarrierInfoViewModel(code: code, carrierInfoService: service, repository: repository)

    }
}

//#Preview {
//    RouteSegmentsListView(segments: [], factory: ServiceFactory())
//}
