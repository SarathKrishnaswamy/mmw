//
//  TicketModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 25/02/25.
//

import Foundation

// Model for a single ticket
struct TicketData: Codable {
    var name: String?
    var ticketID: Int?
    var title: String?
    var userID: Int?
    var desc: String?
    var status: String?
    var priority: String?
    var createdAt: String?
    var updatedAt: String?
    var closedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case ticketID = "TicketID"
        case title = "Title"
        case userID = "UserID"
        case desc = "Description"
        case status = "Status"
        case priority = "Priority"
        case createdAt = "CreatedAt"
        case updatedAt = "UpdatedAt"
        case closedAt = "ClosedAt"
    }
}

// Model for API response
struct TicketModel: Codable {
    var data: [TicketData]?
}


struct storeTicketModel: Codable{
    var message: String?
    var ticket: Int?
    
    enum CodingKeys: String, CodingKey {
        case message
        case ticket = "ticket"
    }
}
