//
//  AddressListModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 26/02/25.
//

import Foundation

struct AddressListModel: Codable {
    let success: Bool?
    let message: String?
    let data: [Address]?
}

struct Address: Codable {
    let id: Int?
    let userID: String?
    let streetAddress: String?
    let locationType: String?
    let parking: String?
    let access: String?
    let pets: String?
    let notes: String?
    let latitude: String?
    let longitude: String?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case streetAddress = "street_address"
        case locationType = "location_type"
        case parking
        case access = "accessibility"
        case pets
        case notes
        case latitude
        case longitude
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}



struct AddressModel: Codable {
    let success: Bool?
    let addresses: [Address]?
}



struct AddressUpdateModel : Codable {
    let message: String?
}
