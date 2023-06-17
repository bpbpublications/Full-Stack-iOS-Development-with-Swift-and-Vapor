//
//  Restaurant.swift
//  RestaurantApp
//
//  Created by hdutt on 27/12/22.
//

import Foundation
import SwiftUI

struct Restaurant: Codable {
    var id: Int?
    var title: String
    var poster: String
    var address: String
    
    private enum RestaurantKeys: String, CodingKey {
        case id
        case title
        case poster
        case address
    }
    
}

extension Restaurant {
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: RestaurantKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.poster = try container.decode(String.self, forKey: .poster)
        self.address = try container.decode(String.self, forKey: .address)
    }
    
    func posterImage() -> Image? {
        guard let stringData = Data(base64Encoded: self.poster),
              let image = UIImage(data: stringData) else {
                  print("Error: couldn't create UIImage")
                  return nil
              }
        
        return Image(uiImage: image)
    }
}
