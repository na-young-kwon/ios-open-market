//
//  Currency.swift
//  OpenMarket
//
//  Created by κΆλμ on 2022/01/22.
//

import Foundation

enum Currency: Int {
    case krw
    case usd
    
    var description: String {
        switch self {
        case .krw:
            return "KRW"
        case .usd:
            return "USD"
        }
    }
}
