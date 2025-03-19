//
//  BusinessType.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 14/03/25.
//

import Foundation


enum BusinessType: Int, CaseIterable {
    case hospitalityAndConcierge = 1
    case eventsAndPromotions
    case homeCareAndSupportServices
    case corporateOffice
    case other
    
    var description: String {
        switch self {
        case .hospitalityAndConcierge:
            return "Hospitality & Concierge"
        case .eventsAndPromotions:
            return "Events & Promotions"
        case .homeCareAndSupportServices:
            return "Home care & Support Services (e.g. Support coordinator or agency)"
        case .corporateOffice:
            return "Corporate Office (e.g. booking for your team)"
        case .other:
            return "Other"
        }
    }
    
    /// Get raw value (Int) from string description
    static func getValue(from description: String) -> Int? {
        return BusinessType.allCases.first { $0.description == description }?.rawValue
    }
    
    /// Get string description from raw value (Int)
    static func getDescription(from value: Int) -> String? {
        return BusinessType(rawValue: value)?.description
    }
    
    /// Get an array of only string descriptions
    static var allDescriptions: [String] {
        return BusinessType.allCases.map { $0.description }
    }
}
