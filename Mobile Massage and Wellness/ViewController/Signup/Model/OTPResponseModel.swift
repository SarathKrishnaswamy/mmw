//
//  OTPResponse.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 22/02/25.
//

import Foundation

struct OTPResponseModel: Codable {
    let message: String?
    let otp: Int?
}
