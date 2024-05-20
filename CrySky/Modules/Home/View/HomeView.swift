//
//  ContentView.swift
//  CrySky
//
//  Created by Mac on 19/05/2024.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    
    @State var isLoading = true
    @State var isLoaded = true
    
    var homeViewModel: HomeViewModel

    private var textColor : Color {
        return homeViewModel.getBackground() == "Day" ? .black : .white
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Image(homeViewModel.getBackground())
                    .ignoresSafeArea()
                if isLoading{
                    if !isLoaded {
                        VStack{
                            Text("Failed To Load Data")
                                .foregroundColor(textColor)
                            Button("ReLoad") {
                                isLoading = true
                                isLoaded = true
                            }
                        }
                    }else{
                        ProgressView()
                            .scaleEffect(2, anchor: .center)
                            .task {
                                homeViewModel.loadData{ loaded in
                                    DispatchQueue.main.async {
                                        if loaded{
                                            isLoading = false
                                        }else{
                                            isLoaded = loaded
                                        }
                                    }
                                }
                            }
                    }
                } else {
                    if let data:WeatherData = homeViewModel.getData() {
                        VStack{
                            Spacer()
                            Spacer()
                            Text("\(data.location?.name ?? "")")
                                .foregroundColor(textColor)
                                .font(.system(size: 38))
                                .bold()
                                .padding(.bottom, 1)
                            Text("\(String(data.current?.tempC ?? 0.0))˚")
                                .foregroundColor(textColor)
                                .font(.system(size: 32))
                                .bold()
                                .padding(.bottom, 1)
                            Text("\(String(data.current?.condition?.text ?? ""))")
                                .foregroundColor(textColor)
                                .font(.system(size: 32))
                                .bold()
                                .padding(.bottom, 1)
                            HStack{
                                Text("H: \(String(data.forecast?.forecastday?[0].day?.maxtempC ?? 0.0))˚")
                                    .foregroundColor(textColor)
                                    .font(.system(size: 24))
                                    .bold()
                                    .padding(.bottom, 1)
                                Text("L: \(String(data.forecast?.forecastday?[0].day?.mintempC ?? 0.0))˚")
                                    .foregroundColor(textColor)
                                    .font(.system(size: 24))
                                    .bold()
                                    .padding(.bottom, 1)
                            }
                            KFImage(URL(string: "http:\(data.current?.condition?.icon ?? "")")).placeholder {
                                Image(.cloud)
                            }
                            List{
                                Section(header: Text("3-DAY FORECAST")
                                    .foregroundColor(textColor)
                                    .font(.headline)) {
                                        
                                        ForEach(data.forecast?.forecastday ?? [], id: \.dateEpoch){ day in
                                            NavigationLink(destination: DetailsView(day: day, color: textColor, backgroundImage: homeViewModel.getBackground(), detailsViewModel: DetailsViewModel())){
                                                HomeCustomCell(day: day, color: textColor)
                                                    .listRowBackground(Color.clear)
                                            }
                                        }
                                    }
                                    .padding(0)
                                    .listRowBackground(Color.clear)
                            }
                            .padding(0)
                            .background(Color.clear)
                            .scrollContentBackground(.hidden)
                            .scrollDisabled(true)
                            
                            Grid(alignment: .center, horizontalSpacing: 48, verticalSpacing: 48) {
                                GridRow {
                                    VStack {
                                        Text("VISIBILITY")
                                            .foregroundColor(textColor)
                                            .font(.system(size: 18))
                                        Text("\(String( data.current?.visKM ?? 0)) Km")
                                            .foregroundColor(textColor)
                                            .font(.title)
                                    }
                                    VStack {
                                        Text("HUMIDITY")
                                            .foregroundColor(textColor)
                                            .font(.system(size: 18))
                                        Text("\(String(data.current?.humidity ?? 0)) %")
                                            .foregroundColor(textColor)
                                            .font(.title)
                                    }
                                }
                                GridRow {
                                    VStack {
                                        Text("FEELS LIKE")
                                            .foregroundColor(textColor)
                                            .font(.system(size: 18))
                                        Text("\(String(data.current?.feelslikeC ?? 0)) °C")
                                            .foregroundColor(textColor)
                                            .font(.title)
                                    }
                                    VStack {
                                        Text("PRESSURE")
                                            .foregroundColor(textColor)
                                            .font(.system(size: 18))
                                        Text("\(String(data.current?.pressureMB ?? 0))")
                                            .foregroundColor(textColor)
                                            .font(.title)
                                    }
                                }
                            }
                            .padding()
                            Spacer()
                        }
                        .padding(.top, 64)
                        .padding(.bottom, 64)
                    }else {
                        VStack{
                            Text("Failed To Load Data")
                                .foregroundColor(textColor)
                            Button("ReLoad") {
                                isLoading = true
                                isLoaded = true
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView(homeViewModel: HomeViewModel(services: NetworkService(),locationManager: LocationManager()))
}
