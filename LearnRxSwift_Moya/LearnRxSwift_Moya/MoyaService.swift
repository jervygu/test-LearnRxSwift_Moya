//
//  MoyaService.swift
//  LearnRxSwift_Moya
//
//  Created by Jeff Umandap on 3/23/23.
//

import Foundation
import Moya


enum MoyaService: TargetType {
//    var path: String
//    var method: Moya.Method
//    var task: Moya.Task
//    var headers: [String : String]?
    
    
    var baseURL: URL {
        return URL(string: "https://reqres.in")!
    }
    
    case getUser(userID: String)
    case getAllUsers(page: String)
    case login(email: String, password: String)
    
    
    // https://reqres.in/api/user?page=2
    
    var path: String {
        switch self {
        case .getUser(let id):
            return "/api/users/\(id)"
        case .getAllUsers:
            return "/api/users" //
        case .login:
            return "/api/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUser, .getAllUsers:
            return .get
        case .login:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getUser:
            return .requestPlain
        case .getAllUsers(let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.default)
        case .login(let email, let password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getUser, .getAllUsers, .login:
            return [
                "Accept": "application/json",
                "Content-type": "application/json"
            ]
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getUser, .getAllUsers, .login:
            return "should be filled properly".utf8Encoded
        }
    }
    
}

private extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
