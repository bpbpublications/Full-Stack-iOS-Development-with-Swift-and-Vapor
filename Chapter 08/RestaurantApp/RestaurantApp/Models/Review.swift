//
//  Review.swift
//  RestaurantApp
//
//  Created by hdutt on 27/12/22.
//

import Foundation

struct Review: Codable {
    var id: Int?
    var title: String
    var body: String
    var restaurant: Restaurant?
}
