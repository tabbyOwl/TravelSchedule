//
//  FilterButtonView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/18.
//

import SwiftUI

struct FilterButtonView: View {
    // MARK: - Private Properties
    private var isFiltersOn: Bool
    
    // MARK: - Init
    init(isFiltersOn: Bool) {
        self.isFiltersOn = isFiltersOn
    }
    
    // MARK: - Body
    var body: some View {
        HStack {
            Text("Уточнить время")
                .foregroundStyle(.white)
                .font(.system(size: 17, weight: .bold))
            
            if isFiltersOn {
                Circle()
                    .fill(.orange)
                    .frame(width: 10, height: 10)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.blueUniversal)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    FilterButtonView(isFiltersOn: true)
}
