//
//  ContentView.swift
//  HelloWorldSwiftUI
//
//  Created by hdutt on 22/11/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("scene")
                .resizable()
                .scaledToFit()
            
            Text("Hello World")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .foregroundColor(Color.green)

            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
