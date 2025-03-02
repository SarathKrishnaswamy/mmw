//
//  SavePreferenceModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 02/03/25.
//

import Foundation

// MARK: - Generic Success Response Model
struct SavePreferenceModel: Codable {
    let success: Bool?
    let message: String?
}
