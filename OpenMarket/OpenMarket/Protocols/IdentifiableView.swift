//
//  IdentifiableView.swift
//  OpenMarket
//
//  Created by κΆλμ on 2022/01/17.
//

import Foundation

protocol IdentifiableView {
    static var identifier: String { get }
}

extension IdentifiableView {
    static var identifier: String {
        return String(describing: self)
    }
}
