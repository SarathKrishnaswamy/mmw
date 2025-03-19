//
//  BookingStatus.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 04/03/25.
//

import Foundation
import UIKit
enum BookingStatusResponse: Int, Codable {
    case rejected = 1
    case accepted = 2
    case clientCancel = 3
    case serviceProviderCancel = 4
    case timeoutCancel = 5
    case noClientCancel = 6
    case completed = 7
    case payout = 8
    case booking = 9
    case withoutPaymentCancel = 10
    case pending = 0

    var description: String {
        switch self {
        case .rejected: return "Rejected"
        case .accepted: return "Accepted"
        case .clientCancel: return "Client Cancel Booking"
        case .serviceProviderCancel: return "Service Provider Cancel Booking"
        case .timeoutCancel: return "Time out Cancel Booking"
        case .noClientCancel: return "No Client Cancel Booking"
        case .completed: return "Booking Completed"
        case .payout: return "Payout"
        case .booking: return "Booking"
        case .withoutPaymentCancel: return "Without Payment Cancel"
        case .pending: return "Pending"
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(Int.self)
        self = BookingStatusResponse(rawValue: value) ?? .pending // Default to pending if unknown
    }
}


extension BookingStatusResponse {
    var color: UIColor {
        switch self {
        case .rejected, .clientCancel, .serviceProviderCancel, .timeoutCancel, .noClientCancel, .withoutPaymentCancel:
            return UIColor.danger // Red for cancellations and rejections
        case .accepted, .booking:
            return UIColor.success // green for accepted/booked statuses
        case .completed, .payout:
            return UIColor.violet // violet for completed bookings
        case .pending:
            return UIColor.warning // Orange for pending bookings
        }
    }
}
