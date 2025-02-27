//
//  UserSignUpResponse.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 23/02/25.
//

import Foundation

struct UserSignUpModel: Codable {
    let message: String?
    let user: UserData?
}

struct UserData: Codable {
    let name: String?
    let email: String?
    let mobileNumber: String?
    let lastLoginAt: String?
    let lastLoginIP: String?
    let updatedAt: String?
    let createdAt: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case name, email, id
        case mobileNumber = "mobile_number"
        case lastLoginAt = "last_login_at"
        case lastLoginIP = "last_login_ip"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}
