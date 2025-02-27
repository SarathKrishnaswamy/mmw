//
//  LoginResponse.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 20/02/25.
//

import Foundation

struct User: Codable {
    let id: Int?
    let name: String?
    let email: String?
    let mobileNumber: String?
    let profilePhotoPath: String?
    let emailVerifiedAt: String?
    let avatar: String?
    let appStatus: Int?
    let createdAt: String?
    let updatedAt: String?
    let lastLoginAt: String?
    let lastLoginIP: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, email
        case mobileNumber = "mobile_number"
        case profilePhotoPath = "profile_photo_path"
        case emailVerifiedAt = "email_verified_at"
        case avatar, appStatus = "app_status"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case lastLoginAt = "last_login_at"
        case lastLoginIP = "last_login_ip"
    }
}

struct LoginResponseModel: Codable {
    let message: String?
    let user: User?
    let token: String?
}
