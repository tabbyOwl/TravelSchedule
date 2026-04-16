//
//  MainSearchView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//

import SwiftUI

struct MainSearchView: View {
    
    @State private var viewModel = MainSearchViewModel()
    
    init(viewModel: MainSearchViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            content
            
            if viewModel.areCitiesSelected {
                NavigationLink(destination: EmptyView()) {
                    Text("Найти")
                        .foregroundStyle(.white)
                        .font(.system(size: 17, weight: .bold))
                }
                .padding()
                .frame(width: MainSearchLayout.searchButtonWidth)
                .background(.blueUniversal)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
    }
}

private extension MainSearchView {
    var content: some View {
        HStack {
            inputViews
            swapButton
        }
        .padding()
        .background(.blueUniversal)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
            
        }
    }

private extension MainSearchView {
    var inputViews: some View {
        VStack() {
            inputRowView(station: viewModel.fromStation)
            inputRowView(station: viewModel.toStation)
        }
        .frame(width: MainSearchLayout.inputWidth)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }

private extension MainSearchView {
    func inputRowView(station: Station) -> some View {
        
        NavigationLink(destination: EmptyView()) {
            rowView(title: station.title)
        }
    }
}


private extension MainSearchView {
    func rowView(title: String) -> some View {
        let isSelected = viewModel.isSelected(title: title)
        return Text(title)
            .foregroundStyle(isSelected ? .blackUniversal : .grayUniversal)
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(1)
            .padding()
    }
}

private extension MainSearchView {
    var swapButton: some View {
        Button(action: viewModel.swap) {
            Image(.change)
                .frame(width: 36, height: 36)
                .background(.white)
                .clipShape(.circle)
        }
    }
}

#Preview {
    MainSearchView(viewModel: MainSearchViewModel())
}
