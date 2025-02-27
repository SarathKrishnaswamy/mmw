//
//  NetworkConstants.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 20/02/25.
//

import Foundation

struct NetworkConstants {
    
    struct Endpoints {
        static let login = "auth/login"
        static let mobileOtp = "auth/generate-otp"
        static let emailOtp = "auth/generate-otp-mail"
        static let signup = "auth/register"
        static let dashboard = "dashboard"
        static let logout = "auth/destroy"
        static let forgotPassword = "auth/forgot-password"
        static let getTickets = "tickets"
        static let storeTickets = "tickets/store"
        static let paymentHistory = "reports/payment-history"
        static let getAddressList = "booking/address_list"
        static let locationSettings = "settings/address_setting"
        static let addressView = "booking/address_view/"
        static let addressUpdate = "booking/address_edit/"
        static let addressDelete = "booking/address_delete/"
        static let addressStore = "booking/address_store"
        static let getBookings = "reports/customer-report"
        static let getCustomerDetails = "customer/customer_details"
        static let saveCustomerDetails = "customer/save_customer_profile"
        static let getBusinessDetails = "customer/customer_business"
        static let saveBusinessDetails = "customer/customer_business_save"
    }
    
}
