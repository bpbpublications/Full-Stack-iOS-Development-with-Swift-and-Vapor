//
//  HTTPClient.swift
//  RestaurantApp
//
//  Created by hdutt on 27/12/22.
//

import Foundation

class HTTPClient: ObservableObject {
    
    @Published var restaurants: [Restaurant] = [Restaurant]()
    @Published var reviews: [Review]? = [Review]()
    
    
    func deleteRestaurant(restaurant: Restaurant, completion: @escaping (Bool) -> Void) {
        
        guard let id = restaurant.id,
            let url = URL(string: "http://localhost:8080/restaurant/\(id)") else {
                  fatalError("URL is not defined!")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard let _ = data, error == nil else {
                           return completion(false)
            }
            
            completion(true)
            
        }.resume()
        
    }
    
    func getAllRestaurants() {
        
        guard let url = URL(string: "http://localhost:8080/restaurant") else {
            fatalError("URL is not defined!")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            let restaurants = try? JSONDecoder().decode([Restaurant].self, from: data)
            if let restaurants = restaurants {
                DispatchQueue.main.async {
                    self.restaurants = restaurants
                }
            }
        }.resume()
        
    }
    
    func saveRestaurant(name: String, poster: String, address: String, completion: @escaping (Bool) -> Void) {
       
        guard let url = URL(string: "http://localhost:8080/restaurant") else {
            fatalError("URL is not defined!")
        }
        
        let restaurant = Restaurant(title: name, poster: poster, address: address)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(restaurant)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let _ = data, error == nil else {
                return completion(false)
            }
            
            completion(true)
            
        }.resume()
        
    }
    
    func getReviewsByRestaurant(restaurant: Restaurant) {
        
        guard let id = restaurant.id,
            let url = URL(string: "http://localhost:8080/restaurant/\(id)/reviews") else {
                fatalError("URL is not defined!")
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            let decodedReviews = try? JSONDecoder().decode([Review].self, from: data)
            
            if let decodedReviews = decodedReviews {
                DispatchQueue.main.async {
                     self.reviews = decodedReviews
                }
            }
            
            
        }.resume()
        
    }
    
    func saveReview(review: Review, completion: @escaping (Bool) -> Void) {
        
        guard let url = URL(string: "http://localhost:8080/reviews") else {
            fatalError("URL is not defined!")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(review)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let _ = data, error == nil else {
                return completion(false)
            }
            
            completion(true)
            
        }.resume()
        
    }
    
}
