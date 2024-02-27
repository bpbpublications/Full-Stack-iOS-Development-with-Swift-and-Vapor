//
//  AddRestaurantView.swift
//  RestaurantApp
//
//  Created by hdutt on 28/12/22.
//

import SwiftUI
import PhotosUI

struct AddRestaurantView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var posterPicker: PhotosPickerItem? = nil
    @State private var selectedPoster: Data? = nil
        
    private func saveRestaurant() {
        
        // get the selected poster
        let posterBase64 = selectedPoster?.base64EncodedString() ?? ""
        HTTPClient().saveRestaurant(name: self.name, poster: posterBase64, address: address) { success in
            if success {
                // close the modal
                self.presentationMode.wrappedValue.dismiss()
            } else {
                // show user the error message that save was not successful
            }
        }
    }
    
    private func browseImage() {
        
    }
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                
                VStack(alignment: .center, spacing: 20) {
                    
                    TextField("Enter name", text: self.$name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Enter Address", text: self.$address)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    PhotosPicker(
                            selection: $posterPicker,
                            matching: .images,
                            photoLibrary: .shared()) {
                                Text("Select Poster")
                            }
                            .onChange(of: posterPicker) { newItem in
                                Task {
                                    // Retrive selected asset in the form of Data
                                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                            selectedPoster = data
                                    }
                                }
                            }
                    
                    if let selectedPoster,
                       let uiImage = UIImage(data: selectedPoster) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 250)
                    }
                    
                    Button("Add Restaraunt") {
                        
                        // save the movie
                        self.saveRestaurant()
                    }
                    .padding(8)
                    .foregroundColor(Color.white)
                    .background(Color.green)
                    .cornerRadius(8)
                    
                }.padding()
                    .background(Color.black)
                                
            }
                
            .navigationBarTitle("Add Restaurant")
            .navigationBarItems(trailing: Button("Close") {
                print("closed fired")
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddMovieView_Previews: PreviewProvider {
    static var previews: some View {
        AddRestaurantView()
    }
}
