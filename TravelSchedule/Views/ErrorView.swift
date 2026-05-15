//
//  ErrorView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//

import SwiftUI

enum ErrorMode {
    case noInternet
    case serverError
}

struct ErrorView: View {
    
    private let mode: ErrorMode
    
    private var title: String {
        switch mode {
        case .noInternet:
            "Нет интернета"
        case .serverError:
            "Ошибка сервера"
        }
    }
    
    private var image: Image {
        switch mode {
        case .noInternet:
            return Image(.noInternet)
        case .serverError:
            return Image(.serverError)
        }
    }
    
    init(mode: ErrorMode) {
            self.mode = mode
    }
    
    var body: some View {
        VStack(spacing: 16) {
            image
                .resizable()
                .scaledToFit()
                .frame(width: 220, height: 220)
            
            Text(title)
                .font(.system(size: 24, weight: .bold))
        }
    }
}


#Preview {
    ErrorView(mode: .serverError)
}
