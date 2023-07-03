//
//  myService.swift
//  DarshanaDRCPractical
//
//  Created by Ravi on 02/07/23.
//

import Foundation
import Moya
enum MyService {
    case productList
}

private extension String {
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data { Data(self.utf8) }
}

// MARK: - TargetType Protocol Implementation
extension MyService: TargetType {
    var baseURL: URL { URL(string: "https://fakestoreapi.com/")! }
    var path: String {
        switch self {
        case .productList:
            return "products"
        }
    }
    var method: Moya.Method {
        switch self {
        case .productList:
            return .get
    
        }
    }
    var task: Task {
        switch self {
        case .productList: // Send no parameters
            return .requestPlain
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
