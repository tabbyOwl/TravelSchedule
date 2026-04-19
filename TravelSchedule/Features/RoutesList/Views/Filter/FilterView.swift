//
//  FilterView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//
import SwiftUI

struct FilterView: View {
    
    // MARK: - Bindings
    @Binding private var showTransfers: Bool
    @Binding private var selectedIntervals: Set<TimeInterval>
    
    // MARK: - State
    @State private var currentSelectedIntervals: Set<TimeInterval> = []
    
    // MARK: - Environment
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Private Properties
    private var timeIntervals: [TimeInterval] = TimeIntervals.intervals
    
    // MARK: - Init
    init(selectedIntervals: Binding<Set<TimeInterval>>,
         showTransfers: Binding<Bool>) {
        _selectedIntervals = selectedIntervals
        self.currentSelectedIntervals = selectedIntervals.wrappedValue
        _showTransfers = showTransfers
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            timeSection
            transfersSection
            Spacer()
            applyButton
        }
    }
    
    // MARK: - Views
    private var timeSection: some View {
        VStack(alignment: .leading) {
            Text("Время отправления")
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .font(.system(size: 24, weight: .bold))
            
            ForEach(timeIntervals) { interval in
                timeRow(interval)
            }
        }
    }
    
    private var transfersSection: some View {
        VStack(alignment: .leading) {
            Text("Показывать варианты с пересадками")
                .padding(.horizontal, 16)
                .font(.system(size: 24, weight: .bold))
            
            transferRow(title: "Да", isSelected: showTransfers)
            transferRow(title: "Нет", isSelected: !showTransfers)
        }
    }
    
    private var applyButton: some View {
        Button("Применить фильтры") {
            dismiss()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.blueUniversal)
        .foregroundStyle(.white)
        .font(.system(size: 17, weight: .bold))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding()
    }
    
    // MARK: - Rows
    
    private func timeRow(_ interval: TimeInterval) -> some View {
        let isSelected = currentSelectedIntervals.contains(interval)
        
        return HStack {
            Text(interval.displayName)
            Spacer()
            Image(systemName: isSelected ? "checkmark.square.fill" : "square")
        }
        .padding()
        .contentShape(Rectangle())
        .onTapGesture {
            toggleTime(interval)
        }
    }
    
    private func transferRow(title: String, isSelected: Bool) -> some View {
        HStack {
            Text(title)
            Spacer()
            Image(systemName: isSelected ? "circle.circle.fill" : "circle")
        }
        .padding()
        .onTapGesture {
            showTransfers.toggle()
        }
    }
    
    // MARK: - Actions
    private  func toggleTime(_ interval: TimeInterval) {
        if currentSelectedIntervals.contains(interval) {
            currentSelectedIntervals.remove(interval)
            
        } else {
            currentSelectedIntervals.insert(interval)
        }
        selectedIntervals = currentSelectedIntervals
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(selectedIntervals: .constant([]), showTransfers: .constant(true))
    }
}
