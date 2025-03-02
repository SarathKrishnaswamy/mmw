//
//  GetPreferenceModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 02/03/25.
//

import Foundation


// MARK: - Massage Preferences Response Model
struct GetPreferenceModel: Codable {
    let success: Bool?
    let data: GetPreferenceData?
}

// MARK: - Massage Preferences Data Model
struct GetPreferenceData: Codable {
    let awareOption: String?
    let userId: Int?
    let moreInfo: String?
    let areas: String?
    let allergies: String?
    let towelsSheet: String?
    let pressurePreference: String?
    let communicationPreference: String?
    let note: String?

    enum CodingKeys: String, CodingKey {
        case awareOption = "aware_option"
        case userId = "user_id"
        case moreInfo = "more_info"
        case areas
        case allergies
        case towelsSheet = "towels_sheet"
        case pressurePreference = "presure_preference"
        case communicationPreference = "communication_preference"
        case note
    }
}
