//
//  PaymentHistoryModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 26/02/25.
//

import Foundation

// MARK: - Main Response Model
struct PaymentHistoryModel: Codable {
    let success: Bool?
    let data: PaymentHistoryData?
}

// MARK: - Data Model
struct PaymentHistoryData: Codable {
    let paymentHistories: [PaymentHistory]?
    let statuses: [String: String]?
    let clients: [Client]?
    let services: [Service]?
    let bookingDates: [String: String]?
    let paymentDates: [String: String]?
}

// MARK: - Payment History Model
struct PaymentHistory: Codable {
    let id: Int?
    let userID: Int?
    let bookingID: Int?
    let orderID: Int?
    let customerID: String?
    let intentKey: String?
    let clientSecret: String?
    let gateway: String?
    let paymentID: String?
    let country: String?
    let code: String?
    let total: Int?
    let hoursRate: Int?
    let dayRate: Int?
    let parking: Int?
    let notes: String?
    let status: Int?
    let acceptStatus: Int?
    let suggestedTime: String?
    let mailStatus: String?
    let paymentMethods: String?
    let createdAt: String?
    let updatedAt: String?
    let paymentDate: String?
    let bookingDate: String?
    let session: String?
    let treatment: String?
    let duration: String?
    let date: String?
    let startingTime: String?
    let totalAmount: Int?

    enum CodingKeys: String, CodingKey {
        case id, total, status, notes, session, treatment, duration, date
        case userID = "user_id"
        case bookingID = "booking_id"
        case orderID = "order_id"
        case customerID = "customer_id"
        case intentKey = "intent_key"
        case clientSecret = "client_secret"
        case gateway, paymentID, country, code
        case hoursRate = "hours_rate"
        case dayRate = "day_rate"
        case parking, acceptStatus, suggestedTime, mailStatus
        case paymentMethods = "payment_methods"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case paymentDate = "payment_date"
        case bookingDate = "booking_date"
        case startingTime = "starting_time"
        case totalAmount = "total_amount"
    }
}

// MARK: - Client Model
struct Client: Codable {
    let name: String?
}

// MARK: - Service Model
struct Service: Codable {
    let name: String?
}
