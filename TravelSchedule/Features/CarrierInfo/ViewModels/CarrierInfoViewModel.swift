//
//  CarrierInfoViewModel.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/20.
//
import SwiftUI

@Observable
final class CarrierInfoViewModel {
    
    private var _carrier: Carrier
    
    var carrier: Carrier {
        _carrier
    }
    
    init(carrier: Carrier) {
        self._carrier = carrier
    }
    
}
