//
//  BookServiceViewModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 04/03/25.
//

import Foundation

struct DurationResponse: Codable {
    let status: String?
    let message: String?
    let data: DurationData?
}

struct DurationData: Codable {
    let duration: [String]?
}


struct TreatmentResponse: Codable {
    let status: String?
    let message: String?
    let data: TreatmentData?
}

struct TreatmentData: Codable {
    let treatment: [String]?
}


struct GenderResponse: Codable {
    let status: String?
    let message: String?
    let data: GenderData?
}

struct GenderData: Codable {
    let gender: [String]?
}


struct ServicesSettingModel: Codable {
    let status: String?
    let message: String?
    let data: ServicesSettingData?
}

struct ServicesSettingData: Codable {
    let services: [ServicesResponse]?
    let categories: [Category]?
}

struct ServicesResponse: Codable {
    let id: Int?
    let categoryID: Int?
    let name: String?
    let description: String?
    let price: Int?
    let status: Int?
    let createdAt: String?
    let updatedAt: String?
    let categoryName: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case name
        case description
        case price
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case categoryName = "category_name"
    }
}

struct Category: Codable {
    let id: Int?
    let categoryName: String?
    let slug: String?
    let status: Int?
    let createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case categoryName = "category_name"
        case slug
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


enum Gender: String, Codable, CaseIterable {
    case noPreference = "No Preference"
    case femaleOnly = "Female Only"
    case femalePreferred = "Female Preferred"
    case maleOnly = "Male Only"
    case malePreferred = "Male Preferred"
    
    static var allCasesAsStrings: [String] {
           return Gender.allCases.map { $0.rawValue }
       }
    
    static var allAPIValues: [String] {
        return Gender.allCases.map { $0.apiValue }
    }
    
    init?(apiValue: String) {
        switch apiValue {
        case "no_preference": self = .noPreference
        case "female_only": self = .femaleOnly
        case "female_preferred": self = .femalePreferred
        case "male_only": self = .maleOnly
        case "male_preferred": self = .malePreferred
        default: return nil
        }
    }
    
    var apiValue: String {
        switch self {
        case .noPreference: return "no_preference"
        case .femaleOnly: return "female_only"
        case .femalePreferred: return "female_preferred"
        case .maleOnly: return "male_only"
        case .malePreferred: return "male_preferred"
        }
    }
}
