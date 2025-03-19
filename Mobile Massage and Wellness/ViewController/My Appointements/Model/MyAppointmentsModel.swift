//
//  MyAppointmentsModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 04/03/25.
//

import Foundation


struct MyAppointmentsModel: Codable {
    let success: Bool?
    let data: MyAppointmentsData?
}

struct MyAppointmentsData: Codable {
    let upcomingBookings: [Booking]?
    let previousBookings: [Booking]?
    
    enum CodingKeys: String, CodingKey {
        case upcomingBookings = "upcoming_bookings"
        case previousBookings = "previous_bookings"
    }
}

struct Booking: Codable {
    let id: Int?
    let bookingID: Int?
    let userID: Int?
    let session: String?
    let duration: String?
    let treatment: String?
    let addon: String?
    let gender: String?
    let addressID: Int?
    let createdAt: String?
    let updatedAt: String?
    let name: String?
    let mobileNumber: String?
    let profilePhotoPath: String?
    let streetAddress: String?
    let latitude: String?
    let longitude: String?
    let acceptStatus: Int?
    let bookingDate: String?
    let bookingTime: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case bookingID = "booking_id"
        case userID = "user_id"
        case session, duration, treatment, addon, gender
        case addressID = "address_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case name, mobileNumber = "mobile_number"
        case profilePhotoPath = "profile_photo_path"
        case streetAddress = "street_address"
        case latitude, longitude
        case acceptStatus = "accept_status"
        case bookingDate = "booking_date"
        case bookingTime = "booking_time"
    }
}
