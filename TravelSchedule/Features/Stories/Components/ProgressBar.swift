//
//  ProgressBar.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/21.
//

import SwiftUI

extension CGFloat {
    static let progressBarCornerRadius: CGFloat = 3
    static let progressBarHeight: CGFloat = 6
}

struct ProgressBar: View {
    let numberOfSections: Int
    let progress: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                    .frame(width: geometry.size.width, height: .progressBarHeight)
                    .foregroundColor(.white)
                
                RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                    .frame(
                        width: min(
                            progress * geometry.size.width,
                            geometry.size.width
                        ),
                        height: .progressBarHeight
                    )
                    .foregroundColor(.blueUniversal)
            }
            .mask {
                MaskView(numberOfSections: numberOfSections)
            }
        }
    }
}

private struct MaskView: View {
    let numberOfSections: Int

    var body: some View {
        HStack {
            ForEach(0..<numberOfSections, id: \.self) { _ in
                MaskFragmentView()
            }
        }
        
    }
}

private struct MaskFragmentView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: .progressBarCornerRadius)
            .frame(height: .progressBarHeight)
            .foregroundStyle(.white)
    }
}


#Preview {
    Color.blackUniversal
        .ignoresSafeArea()
        .overlay(
            ProgressBar(numberOfSections: 5, progress: 0.5)
                .padding()
        )
}
