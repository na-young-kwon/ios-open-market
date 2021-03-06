//
//  Product.swift
//  OpenMarket
//
//  Created by κΆλμ on 2022/01/03.
//

import Foundation

struct Product: Decodable, ProductPresentable {
    let id: Int
    let vendorID: Int
    let name: String
    let thumbnailURL: String
    let currency: String
    let price: Double
    let bargainPrice: Double
    let discountedPrice: Double
    let stock: Int
    let createdAt: String
    let issuedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name, currency, price, stock
        case vendorID = "vendor_id"
        case thumbnailURL = "thumbnail"
        case bargainPrice = "bargain_price"
        case discountedPrice = "discounted_price"
        case createdAt = "created_at"
        case issuedAt = "issued_at"
    }
}
