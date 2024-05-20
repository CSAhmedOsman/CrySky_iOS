//
//  CrySkyApp.swift
//  CrySky
//
//  Created by Mac on 19/05/2024.
//

import SwiftUI

@main
struct CrySkyApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(homeViewModel: HomeViewModel(services: NetworkService(),locationManager: LocationManager()))
        }
    }
}
