//
//  FilterView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//
import SwiftUI

struct FilterView: View {
    @Binding private var selectedIntervals: Set<TimeInterval>
    @State private var currentSelectedIntervals: Set<TimeInterval> = []
    @Binding private var showTransfers: Bool
    @Environment(\.dismiss) private var dismiss
    
    private var timeIntervals: [TimeInterval] = TimeIntervals.intervals
    
    init(selectedIntervals: Binding<Set<TimeInterval>>,
         showTransfers: Binding<Bool>) {
        _selectedIntervals = selectedIntervals
        self.currentSelectedIntervals = selectedIntervals.wrappedValue
        _showTransfers = showTransfers
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            timeSection
            transfersSection
            Spacer()
            applyButton
        }
    }
}

private extension FilterView {
    var timeSection: some View {
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
}

private extension FilterView {
    func timeRow(_ interval: TimeInterval) -> some View {
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
}

private extension FilterView {
    func toggleTime(_ interval: TimeInterval) {
        if currentSelectedIntervals.contains(interval) {
            currentSelectedIntervals.remove(interval)
            
        } else {
            currentSelectedIntervals.insert(interval)
        }
        selectedIntervals = currentSelectedIntervals
    }
}

private extension FilterView {
    var transfersSection: some View {
        VStack(alignment: .leading) {
            Text("Показывать варианты с пересадками")
                .padding(.horizontal, 16)
                .font(.system(size: 24, weight: .bold))
            
            transferRow(title: "Да", isSelected: showTransfers)
            transferRow(title: "Нет", isSelected: !showTransfers)
        }
    }
}

private extension FilterView {
    func transferRow(title: String, isSelected: Bool) -> some View {
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
}

private extension FilterView {
    var applyButton: some View {
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
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(selectedIntervals: .constant([]), showTransfers: .constant(true))
    }
}
