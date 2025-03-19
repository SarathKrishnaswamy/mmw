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

func formatDateTimeNoAMPM(_ dateString: String) -> String? {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    inputFormatter.locale = Locale(identifier: "en_US_POSIX")

    if let date = inputFormatter.date(from: dateString) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd hh:mm"
        return outputFormatter.string(from: date)
    }
    
    return nil
}


func formatDateTimeDayMonth(_ dateString: String) -> String? {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    inputFormatter.locale = Locale(identifier: "en_US_POSIX")

    if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "EEEE MMMM d, yyyy" // Example: Friday March 1, 2025
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



func convertDateToDateOnly(_ dateString: String) -> String? {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "dd/MM/yyyy"
    inputFormatter.locale = Locale(identifier: "en_US_POSIX")

    if let date = inputFormatter.date(from: dateString) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd"
        
        return outputFormatter.string(from: date)
    }
    
    return nil
}


func formatDateDayMonth(_ dateString: String) -> String? {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd"
    inputFormatter.locale = Locale(identifier: "en_US_POSIX")

    if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "EEEE MMMM d, yyyy" // Example: Friday March 1, 2025
            return outputFormatter.string(from: date)
        }
    
    return nil
}


func removeAMPM(from timeString: String) -> String {
    return timeString.replacingOccurrences(of: "\\s?(AM|PM)", with: "", options: .regularExpression)
}
