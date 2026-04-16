//
//  RouteCardView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//
import SwiftUI

struct RouteCardView: View {
    
    private let segment: Segment
    
    init(segment: Segment) {
        self.segment = segment
    }
    
    var body: some View {
        VStack {
            topStack
            bottomStack
        }
        .padding()
        .background(.lightGrayUniversal)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .padding(.leading)
        .padding(.trailing)
    }
}

private extension RouteCardView {
    var topStack: some View {
        HStack(alignment: .top) {
            Image(systemName: "sun.min")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 38, height: 38)
                .scaledToFit()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(alignment: .leading, spacing: 0) {
                Text(segment.carrierName)
                    .font(.system(size: 17, weight: .regular))
                    .lineLimit(1)
                    
                Text(segment.hasTransfers ? "С пересадкой" : "")
                    .foregroundStyle(.redUniversal)
                    .font(.system(size: 12, weight: .regular))
            }
            Spacer()
            Text(segment.date)
                .font(.system(size: 12, weight: .regular))
        }
    }
}

private extension RouteCardView {
    var bottomStack: some View {
        HStack {
            Text(segment.departure)
                .fixedSize(horizontal: true, vertical: false)
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color.grayUniversal)
            
            Text(segment.duration)
                .fixedSize(horizontal: true, vertical: false)
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color.grayUniversal)
            Text(segment.arrival)
                .fixedSize(horizontal: true, vertical: false)
        }
        .font(.system(size: 17, weight: .regular))
        .padding(4)
    }
}


#Preview {
    NavigationLink(destination: EmptyView()) {
        RouteCardView(segment: Segment(carrierName: "Российские Железные Дороги", carrierCode: 45, logo: "", hasTransfers: true, departure: "13:05", arrival: "12:45", duration: "9 часов", date: "12 апреля"))
    }.foregroundStyle(.blackUniversal)
}
