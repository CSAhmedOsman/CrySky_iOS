//
//  Utils.swift
//  CrySky
//
//  Created by Mac on 20/05/2024.
//

import Foundation

struct Utils {
    static func getDayName(epoch: Int) -> String{
        let day = Date(timeIntervalSince1970: TimeInterval(epoch)).formatted(Date.FormatStyle().weekday(.abbreviated))
      let today = Date().formatted(Date.FormatStyle().weekday(.abbreviated))
        return today == day ? "Today" : day
    }
    
}


