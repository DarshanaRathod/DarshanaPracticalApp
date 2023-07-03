//
//  Product.swift
//  DarshanaDRCPractical
//
//  Created by Technource on 03/07/23.
//

import Foundation
import Foundation

// MARK: - Product
struct Products: Codable {
    let id: Int
    let title: String
    let price: Double
    let productDescription: String
    let category: String
    let image: URL
    let rating: Ratings

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case price = "price"
        case productDescription = "description"
        case category = "category"
        case image = "image"
        case rating = "rating"
    }
}

// MARK: - Rating
struct Ratings: Codable {
    let rate: Double
    let count: Int

    enum CodingKeys: String, CodingKey {
        case rate = "rate"
        case count = "count"
    }
}
