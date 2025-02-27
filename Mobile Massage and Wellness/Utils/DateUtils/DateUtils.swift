//
//  DateUtils.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 26/02/25.
//

import Foundation

func formatDateTime(_ dateString: String) -> String? {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    inputFormatter.locale = Locale(identifier: "en_US_POSIX")

    if let date = inputFormatter.date(from: dateString) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd | h:mm a"
        outputFormatter.amSymbol = "AM"
        outputFormatter.pmSymbol = "PM"

        return outputFormatter.string(from: date)
    }
    
    return nil
}


func convertToDateOnly(_ dateString: String) -> String? {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    inputFormatter.locale = Locale(identifier: "en_US_POSIX")

    if let date = inputFormatter.date(from: dateString) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd"
        
        return outputFormatter.string(from: date)
    }
    
    return nil
}
