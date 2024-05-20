//
//  HomeCustomCell.swift
//  CrySky
//
//  Created by Mac on 20/05/2024.
//

import SwiftUI
import Kingfisher

struct HomeCustomCell: View {
    
    var day: Forecastday?
    var color: Color
    
    var body: some View {
        HStack{
            Spacer()
            Spacer()
            Text(Utils.getDayName(epoch: day?.dateEpoch ?? 0))
                .foregroundColor(color)
            Spacer()
            KFImage(URL(string: "http:\(day?.day?.condition?.icon ?? "")")).placeholder {
                Image(.cloud)
            }
            Spacer()
            Text("\(String(day?.day?.maxtempC ?? 0))˚")
                .foregroundColor(color)
            Spacer()
            Text("\(String(day?.day?.mintempC ?? 0))˚")
                .foregroundColor(color)
            Spacer()
            Spacer()
        }
        .background(Color.clear)
    }
}

#Preview {
    HomeCustomCell(day: nil, color: .black)
}
