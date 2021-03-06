//
//  APIError+Extensions.swift
//  OpenMarketTests
//
//  Created by κΆλμ on 2022/01/10.
//

import Foundation
@testable import OpenMarket

extension APIError: Equatable {
    public static func == (lhs: APIError, rhs: APIError) -> Bool {
        return lhs.description == rhs.description
    }
}
