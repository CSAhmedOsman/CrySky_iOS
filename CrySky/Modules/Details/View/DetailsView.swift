//
//  DetailsView.swift
//  CrySky
//
//  Created by Mac on 20/05/2024.
//

import SwiftUI

struct DetailsView: View {
    
    var day: Forecastday?
    var color: Color
    var backgroundImage: String
    var detailsViewModel: DetailsViewModel

    var body: some View {
        ZStack{
            Image(backgroundImage)
                .resizable()
                .ignoresSafeArea(.all)
            
            List(detailsViewModel.subHoursArray(from: day?.hour ?? [], dateEpoch: day?.dateEpoch ?? 0), id: \.time){ item in
                DetailsCustomCell(hour: item, color: color)
                    .listRowBackground(Color.clear)
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(color) , alignment: .top)
            }
            .foregroundStyle(color)
            .listRowBackground(Color.clear)
            .background(Color.clear)
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    DetailsView(day: nil, color: .black, backgroundImage: "Day", detailsViewModel: DetailsViewModel())
}
