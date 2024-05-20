//
//  DetailsViewModel.swift
//  CrySky
//
//  Created by Mac on 20/05/2024.
//

import Foundation

class DetailsViewModel{
    
    func filteredAndFormattedHours(day: Forecastday) -> [Hour] {
        let currentHour = Calendar.current.component(.hour, from: Date())
        var filteredHours = day.hour?.filter { hour in
            if let hourInt = Int(hour.time?.prefix(2) ?? "") {
                return hourInt >= currentHour
            }
            return false
        }
        
        if !(filteredHours?.isEmpty ?? false) {
            filteredHours?[0].time = "Now"
        }
        
        return filteredHours ?? []
    }
    
    func getCurrentHour() -> Int {
        let currentHour = Calendar.current.component(.hour, from: Date())
        return currentHour
    }
    
    func subHoursArray(from hours: [Hour], dateEpoch: Int) -> [Hour] {
        let currentHour = getCurrentHour()
        
        guard currentHour >= 0 && currentHour < 24 else {
            
            return []
        }
        let calendar = Calendar.current
        let currentDay = calendar.component(.day, from: Date())
        
        let forecastDay = calendar.component(.day, from: Date(timeIntervalSince1970: TimeInterval(dateEpoch)))
        
        
        if currentDay == forecastDay {
            return Array(hours[currentHour..<24])
            
        }else{
            return hours
        }

    }
    
}

