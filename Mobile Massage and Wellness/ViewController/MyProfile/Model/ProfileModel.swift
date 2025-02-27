//
//  ProfileModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 27/02/25.
//

import Foundation


struct ProfileData: Codable {
    let firstname: String?
    let lastname: String?
    let gender: String?
    let mobileNo: String?
    let email: String?
    let vaccinate: String?
    let address: String?
    let dob: String?
    let userId: Int?

    enum CodingKeys: String, CodingKey {
        case firstname
        case lastname
        case gender
        case mobileNo = "mobile_no"
        case email
        case vaccinate
        case address
        case dob
        case userId = "user_id"
    }
}

struct ProfileModel: Codable {
    let data: ProfileData?
}
