//
//  RouteCardTopView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/18.
//

import SwiftUI

struct RouteCardTopView: View {
    // MARK: - Private Properties
    private var carrierName: String
    private var hasTransfers: Bool
    private var date: String
    private var logo: String?
    
    // MARK: - Init
    init(carrierName: String, hasTransfers: Bool, date: String, logo: String?) {
        self.carrierName = carrierName
        self.hasTransfers = hasTransfers
        self.date = date
        self.logo = logo
    }
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .top) {
            LogoImageView(url: logo)
                          .frame(width: 38, height: 38)
                          .background(.white)
                          .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(alignment: .leading, spacing: 0) {
                Text(carrierName)
                    .font(.system(size: 17, weight: .regular))
                    .lineLimit(1)
                    
                Text(hasTransfers ? "С пересадкой" : "")
                    .foregroundStyle(.redUniversal)
                    .font(.system(size: 12, weight: .regular))
            }
            Spacer()
            Text(date)
                .font(.system(size: 12, weight: .regular))
        }
    }
}

#Preview {
    RouteCardTopView(carrierName: "РЖД", hasTransfers: true, date: "13 апреля", logo: "")
}
