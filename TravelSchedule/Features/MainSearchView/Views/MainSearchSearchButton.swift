//
//  MainSearchSearchButton.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/18.
//

import SwiftUI

struct MainSearchSearchButton: View {
    
    var body: some View {
        
        Text(Strings.MainSearch.search)
            .foregroundStyle(.white)
            .font(.system(size: 17, weight: .bold))
            .padding()
            .frame(width: MainSearchLayout.searchButtonWidth)
            .background(.blueUniversal)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
