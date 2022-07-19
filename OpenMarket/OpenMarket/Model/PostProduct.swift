//
//  PostProduct.swift
//  OpenMarket
//
//  Created by Jun Bang on 2022/01/04.
//

import Foundation

struct PostProduct: Encodable {
    let name: String
    let descriptions: String
    let price: Double
    let currency: String
    let discountedPrice: Double?
    let stock: Int?
    let secret: String
    
    init(
        name: String,
        descriptions: String,
        price: Double,
        currency: String,
        discountedPrice: Double? = 0,
        stock: Int? = 0,
        secret: String
    ) {
        self.name = name
        self.descriptions = descriptions
        self.price = price
        self.currency = currency
        self.discountedPrice = discountedPrice
        self.stock = stock
        self.secret = secret
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case descriptions
        case price
        case currency
        case discountedPrice = "discounted_price"
        case stock
        case secret
    }
}
