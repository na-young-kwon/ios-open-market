//
//  URLSessionProtocol.swift
//  OpenMarket
//
//  Created by κΆλμ on 2022/01/04.
//

import Foundation

protocol DataTaskProvidable {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
}

extension URLSession: DataTaskProvidable {}
