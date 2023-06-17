//
//  ContentView.swift
//  RestaurantApp
//
//  Created by hdutt on 28/12/22.
//

import Foundation
import SwiftUI

struct ContentView: View {
    
    @State private var isPresented: Bool = false
    let screenSize = UIScreen.main.bounds
    @ObservedObject var httpClient = HTTPClient()
    
    var body: some View {
        
        NavigationView {
            
            List(self.httpClient.restaurants, id: \.id) { restaurant in
                
                NavigationLink(destination: RestaurantDetailsView(restaurant: restaurant)) {
                    
                    VStack {
                        restaurant.posterImage()?
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text(restaurant.title)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                            .font(.system(size: 25))
                            .cornerRadius(10)
                    }
                }
            }
                
            .navigationBarTitle("Restaurant")
            .navigationBarItems(trailing: Button(action: {
                self.isPresented = true
            }){
                Image(systemName: "plus")
            })
            .onAppear {
                    self.httpClient.getAllRestaurants()
            }
            
        }.sheet(isPresented: $isPresented, onDismiss: {
            self.httpClient.getAllRestaurants()
        }, content: {
            AddRestaurantView()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
