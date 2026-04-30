//
//  CarrierInfoView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//

import SwiftUI

struct CarrierInfoView: View {
    @State private var viewModel: CarrierInfoViewModel
    
    init(viewModel: CarrierInfoViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            logo
            header
            data(title: CarrierInfoStrings.email, data: viewModel.carrier.email)
            data(title: CarrierInfoStrings.phone, data: viewModel.carrier.phone)
            Spacer()
        }
        .padding(.leading, 16)
        .navigationTitle(CarrierInfoStrings.title)
    }
}

private extension CarrierInfoView {
    var logo: some View {
        Image(.carrierLogo)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: CarrierInfoLayout.imageWidth, height: CarrierInfoLayout.imageHeight)
            .scaledToFit()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
}

private extension CarrierInfoView {
    var header: some View {
        Text(viewModel.carrier.title)
            .font(.system(size: 24, weight: .bold))
            .padding(.top)
            .padding(.bottom)
    }
}

private extension CarrierInfoView {
    func data(title: String, data: String) -> some View {
        return VStack(alignment: .leading) {
            Text(title)
            Text(data)
                .foregroundStyle(.blueUniversal)
        }
        .padding(.bottom)
    }
}

#Preview {
    CarrierInfoView(viewModel: CarrierInfoViewModel(carrier: mockCarrier))
}
