//
//  NetworkConfig.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 20/02/25.
//

import Foundation

// MARK: - Network Configuration
struct NetworkConfig {
    static let testBaseURL = "http://laravelvue.stallioni.co.in/api/"
    static let productionBaseURL = "http://laravelvue.stallioni.co.in/api/"

    static var baseURL: String {
        switch Environment.current {
        case .debug:
            return testBaseURL
        case .release:
            return productionBaseURL
        }
    }
}
