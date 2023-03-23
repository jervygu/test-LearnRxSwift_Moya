//
//  UserModel.swift
//  LearnRxSwift_Moya
//
//  Created by Jeff Umandap on 3/23/23.
//

import Foundation


// MARK: - UserResponse
struct UserResponse: Codable {
    let data: UserData
//    let support: Support
}

// MARK: - UserData
struct UserData: Codable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

// MARK: - Support
struct Support: Codable {
    let url: String
    let text: String
}
