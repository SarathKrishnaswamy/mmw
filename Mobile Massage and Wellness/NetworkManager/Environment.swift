//
//  Environment.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 20/02/25.
//

import Foundation
enum Environment {
    case debug
    case release

    static var current: Environment {
        #if DEBUG
        return .debug
        #else
        return .release
        #endif
    }
}
