//
//  LocationModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 26/02/25.
//

import Foundation
struct LocationResponse: Codable {
    let status: String?
    let message: String?
    let data: LocationData?
}

struct LocationData: Codable {
    let locationType: [String]?
    let parking: [String]?
    let haveStairs: [String]?
    let havePets: [String]?

    enum CodingKeys: String, CodingKey {
        case locationType = "location_type"
        case parking
        case haveStairs = "have_stairs"
        case havePets = "have_pets"
    }
}
