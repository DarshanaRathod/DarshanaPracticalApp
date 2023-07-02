//
//  ProductResponseModel.swift
//  DarshanaDRCPractical
//
//  Created by Ravi on 02/07/23.
//

import Foundation

class ProductList{

    var category : String!
    var descriptionField : String!
    var id : Int!
    var image : String!
    var price : Float!
    var rating : Rating!
    var title : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        category = dictionary["category"] as? String
        descriptionField = dictionary["description"] as? String
        id = dictionary["id"] as? Int
        image = dictionary["image"] as? String
        price = dictionary["price"] as? Float
        if let ratingData = dictionary["rating"] as? [String:Any]{
            rating = Rating(fromDictionary: ratingData)
        }
        title = dictionary["title"] as? String
    }

}

class Rating{

    var count : Int!
    var rate : Float!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        count = dictionary["count"] as? Int
        rate = dictionary["rate"] as? Float
    }

}
