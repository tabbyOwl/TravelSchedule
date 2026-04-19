//
//  MainSearchInputView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/18.
//

import SwiftUI

struct MainSearchInputView: View {
    
    // MARK: - Bindings
    @Binding private var fromStation: Station
    @Binding private var toStation: Station
    
    // MARK: - Init
    init(fromStation: Binding<Station>, toStation: Binding<Station>) {
        _fromStation = fromStation
        _toStation = toStation
    }
    
    // MARK: - Body
    var body: some View {
        VStack() {
            InputRowView(station: $fromStation)
            InputRowView(station: $toStation)
        }
        .frame(width: MainSearchLayout.inputWidth)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    MainSearchInputView(fromStation: .constant(Station(title: "Лениградский вокзал", code: "", type: "")), toStation: .constant(Station(title: "Московский вокзал", code: "", type: "")))
}
