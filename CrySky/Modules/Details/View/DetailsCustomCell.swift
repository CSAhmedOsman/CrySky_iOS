//
//  DetailsCustomCell.swift
//  CrySky
//
//  Created by Mac on 20/05/2024.
//

import SwiftUI
import Kingfisher

struct DetailsCustomCell: View {
    
    var hour: Hour?
    var color: Color
    
    var body: some View {
        HStack{
            Spacer()
            Spacer()
            Text("\(hour?.time ?? "Now")")
                .foregroundColor(color)
            Spacer()
            KFImage(URL(string: "http:\(hour?.condition?.icon ?? "")")).placeholder {
                Image(.cloud)
            }
            Spacer()
            Text("\(String(hour?.tempC ?? 0))˚")
                .foregroundColor(color)
            Spacer()
            Spacer()
        }
        .background(Color.clear)
    }
}

#Preview {
    DetailsCustomCell(hour: nil, color: .black)
}
