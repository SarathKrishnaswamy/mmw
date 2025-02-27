//
//  DashboardModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 23/02/25.
//

import Foundation

// MARK: - BookingStatsResponse
struct DashboardModel: Codable {
    let success: Bool?
    let data: DashboardData?
    let roleID: Int?
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case success, data
        case roleID = "role_id"
        case userID = "user_id"
    }
}

// MARK: - BookingData
struct DashboardData: Codable {
    let totalBookings: Int?
    let completedBookings: Int?
    let notAssignedBookings: Int?
    let waitingForApproval: Int?
    let waitingForRescheduleApproval: Int?
    let confirmedBookings: Int?
    let cancelledBookings: Int?
    let payoutBooking: Int?
    let clientCancelBooking: Int?
    let serviceProviderCancelBooking: Int?
    let timeOutCancelBooking: Int?
    let noClientCancelBooking: Int?
    let lastUpdated: String?

    enum CodingKeys: String, CodingKey {
        case totalBookings = "total_bookings"
        case completedBookings = "completed_bookings"
        case notAssignedBookings = "not_assigned_bookings"
        case waitingForApproval = "waiting_for_approval"
        case waitingForRescheduleApproval = "waiting_for_reschedule_approval"
        case confirmedBookings = "confirmed_bookings"
        case cancelledBookings = "cancelled_bookings"
        case payoutBooking = "payout_booking"
        case clientCancelBooking = "client_cancel_booking"
        case serviceProviderCancelBooking = "service_provider_cancel_booking"
        case timeOutCancelBooking = "time_out_cancel_booking"
        case noClientCancelBooking = "no_client_cancel_booking"
        case lastUpdated = "last_updated"
    }
}
