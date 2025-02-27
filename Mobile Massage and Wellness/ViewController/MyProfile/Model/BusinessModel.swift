//
//  BusinessModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 28/02/25.
//

import Foundation

struct BusinessData: Codable {
    let organization: String?
    let businessNumber: String?
    let businessAddress: String?
    let businessType: String?
    let userId: Int?

    enum CodingKeys: String, CodingKey {
        case organization
        case businessNumber = "business_number"
        case businessAddress = "business_address"
        case businessType = "business_type"
        case userId = "user_id"
    }
}

struct BusinessModel: Codable {
    let data: BusinessData?
}
