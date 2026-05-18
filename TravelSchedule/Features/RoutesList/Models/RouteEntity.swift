//
//  RouteEntity.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/5/13.
//
import SwiftData

@Model
final class RouteEntity {
    
    @Attribute(.unique)
    var id: String
    
    @Relationship(deleteRule: .cascade, inverse: \SegmentEntity.route)
    var segments: [SegmentEntity]
    
    init(id: String, segments: [SegmentEntity] = []) {
        self.id = id
        self.segments = segments
    }
}
