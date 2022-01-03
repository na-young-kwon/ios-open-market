//
//  Product.swift
//  OpenMarket
//
//  Created by 권나영 on 2022/01/03.
//

import Foundation

struct Product: Decodable {
    let id: Int
    let vendorID: Int
    let name: String
    let thumbnailURL: String
    let currency: String
    let price: Int
    let bargainPrice: Int
    let discountedPrice: Int
    let stock: Int
    let createdAt: String
    let issuedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case vendorID = "vendor_id"
        case name
        case thumbnailURL = "thumbnail"
        case currency
        case price
        case bargainPrice = "bargain_price"
        case discountedPrice = "discounted_price"
        case stock
        case createdAt = "created_at"
        case issuedAt = "issued_at"
    }
}