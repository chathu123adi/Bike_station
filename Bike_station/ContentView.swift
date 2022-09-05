//
//  ContentView.swift
//  Bike_station
//
//  Created by vinoj randika on 2022-09-03.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var viewModel = StationViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView{
                ForEach(viewModel.stationsData) { item in
                    NavigationLink(destination: StationDetailsView(stationObject: item)) {
                        VStack(spacing: 2) {
                                VStack(alignment: .leading){
                                    Text("\(item.id)     \(item.stationName)")
                                        .font(.system(size: 25, weight: .bold, design: .default))
                                        .frame(alignment: .leading)
                                        
                                    
                                    Text("\(viewModel.findDistance(longitute: item.longitute, Latitute: item.latitude))m - Bike Station")
                                }.frame(
                                    minWidth: 0,
                                    maxWidth: .infinity,
                                    alignment: .topLeading
                                  )
                                .padding()
                                
                                HStack (spacing: 60){
                                    
                                    VStack {
                                        Image("bike").scaledToFit()
                                        Text("Available Bikes")
                                        Text("\(item.availableBike)")
                                            .font(.system(size: 60, weight: .bold))
                                            .foregroundColor(.green)
                                    }
                                    VStack {
                                        Image("lock").scaledToFit()
                                        Text("Available Places")
                                        Text("\(item.availablePlaces)")
                                            .font(.system(size: 60, weight: .bold))
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                        
                            .background(.white)
                            .cornerRadius(15)
                            .overlay( /// apply a rounded border
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(.black, lineWidth: 0.1)
                            )
                            .frame(
                                minWidth: 0,
                                maxWidth: .infinity,
                                alignment: .center
                              )
                            .padding()
                            .foregroundColor(.black)
                            
                            
                            
                            
//                            .padding()
//                                .border(.black, width: 1)
//                                .background(.white)
//                                .cornerRadius(10)
                    }
                }
            }
            .background(Color(hue: 1.0, saturation: 0.007, brightness: 0.956))
            .navigationBarTitleDisplayMode(.inline)
            
//            .navigationBarHidden(true)
        }.onAppear(perform: viewModel.fetchStationData)
            
        
            
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

