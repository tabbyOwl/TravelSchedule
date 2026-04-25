//
//  FilterButtonView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/18.
//

import SwiftUI

struct FilterNavigationView: View {
    
    // MARK: - Bindings
    @Binding private var selectedIntervals: Set<ScheduleInterval>
    @Binding private var showTransfers: Bool
    
    // MARK: - Private properties
    private var isFiltersOn: Bool
    
    // MARK: - Bindings
    init(selectedIntervals: Binding<Set<ScheduleInterval>>, showTransfers: Binding<Bool>, isFiltersOn: Bool) {
        _selectedIntervals = selectedIntervals
        _showTransfers = showTransfers
        self.isFiltersOn = isFiltersOn
    }
    
    // MARK: - Body
    var body: some View {
            NavigationLink(
                destination: FilterView(
                    selectedIntervals: $selectedIntervals,
                    showTransfers: $showTransfers
                )
            ) {
                FilterButtonView(isFiltersOn: isFiltersOn)
                    .padding()
            }
        }
    }


#Preview {
    FilterNavigationView(selectedIntervals: .constant([]), showTransfers: .constant(true), isFiltersOn: true)
}
