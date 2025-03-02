//
//  PreferenceModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 02/03/25.
//

import Foundation

// MARK: - Massage Preferences Response Model
struct PreferenceModel: Codable {
    let status: String?
    let message: String?
    let data: MassagePreferencesData?
}

// MARK: - Massage Preferences Data Model
struct MassagePreferencesData: Codable {
    let areasDict: [String: String]?
    let towelsSheetDict: [String: String]?
    let pressurePreferenceDict: [String: String]?
    let communicationPreferenceDict: [String: String]?

    var areas: [String] { areasDict?.sorted { $0.key < $1.key }.map { $0.value } ?? [] }
    var towelsSheet: [String] { towelsSheetDict?.sorted { $0.key < $1.key }.map { $0.value } ?? [] }
    var pressurePreference: [String] { pressurePreferenceDict?.sorted { $0.key < $1.key }.map { $0.value } ?? [] }
    var communicationPreference: [String] { communicationPreferenceDict?.sorted { $0.key < $1.key }.map { $0.value } ?? [] }

    enum CodingKeys: String, CodingKey {
        case areasDict = "areas"
        case towelsSheetDict = "towels_sheet"
        case pressurePreferenceDict = "presure_preference"
        case communicationPreferenceDict = "communication_preference"
    }
}
