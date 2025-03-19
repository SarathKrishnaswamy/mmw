//
//  ViewBookingModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 04/03/25.
//

import Foundation
import Alamofire

struct ViewBookingModel: Codable {
    let booking : BookingDetails?
    let schedule : Schedule?
    let providerBookings : String?
    let address : AddressResponse?
    let provider : Provider?
    let services : [ServiceResponse]?
    let payment : PaymentResponse?
    let chats : String?
    let reviews : String?
    let recipient : Recipient?
    let holiday_arrays : [String]?
    let booking_ad : Booking_ad?
    let chats_data : String?
    let durations : [Durations]?
    let booking_status : Booking_status?
    
    enum CodingKeys: String, CodingKey {
        
        case booking = "booking"
        case schedule = "schedule"
        case providerBookings = "providerBookings"
        case address = "address"
        case provider = "provider"
        case services = "services"
        case payment = "payment"
        case chats = "chats"
        case reviews = "reviews"
        case recipient = "recipient"
        case holiday_arrays = "holiday_arrays"
        case booking_ad = "booking_ad"
        case chats_data = "chats_data"
        case durations = "durations"
        case booking_status = "booking_status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        booking = try values.decodeIfPresent(BookingDetails.self, forKey: .booking)
        schedule = try values.decodeIfPresent(Schedule.self, forKey: .schedule)
        providerBookings = try values.decodeIfPresent(String.self, forKey: .providerBookings)
        address = try values.decodeIfPresent(AddressResponse.self, forKey: .address)
        provider = try values.decodeIfPresent(Provider.self, forKey: .provider)
        services = try values.decodeIfPresent([ServiceResponse].self, forKey: .services)
        payment = try values.decodeIfPresent(PaymentResponse.self, forKey: .payment)
        chats = try values.decodeIfPresent(String.self, forKey: .chats)
        reviews = try values.decodeIfPresent(String.self, forKey: .reviews)
        recipient = try values.decodeIfPresent(Recipient.self, forKey: .recipient)
        holiday_arrays = try values.decodeIfPresent([String].self, forKey: .holiday_arrays)
        booking_ad = try values.decodeIfPresent(Booking_ad.self, forKey: .booking_ad)
        chats_data = try values.decodeIfPresent(String.self, forKey: .chats_data)
        durations = try values.decodeIfPresent([Durations].self, forKey: .durations)
        booking_status = try values.decodeIfPresent(Booking_status.self, forKey: .booking_status)
    }
}

// MARK: - Schedule
struct Schedule: Codable {
    let id : Int?
    let user_id : Int?
    let booking_id : Int?
    let date : String?
    let earliest_start_time : String?
    let latest_start_time : String?
    let booking_frequency : Int?
    let backup_date : String?
    let back_earliest_start_time : String?
    let back_latest_start_time : String?
    let repeat_month : Int?
    let repeat_frequency : String?
    let booking_method : String?
    let ends_on : String?
    let occurance : String?
    let monthly_repeat : String?
    let created_at : String?
    let updated_at : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case user_id = "user_id"
        case booking_id = "booking_id"
        case date = "date"
        case earliest_start_time = "earliest_start_time"
        case latest_start_time = "latest_start_time"
        case booking_frequency = "booking_frequency"
        case backup_date = "backup_date"
        case back_earliest_start_time = "back_earliest_start_time"
        case back_latest_start_time = "back_latest_start_time"
        case repeat_month = "repeat_month"
        case repeat_frequency = "repeat_frequency"
        case booking_method = "booking_method"
        case ends_on = "ends_on"
        case occurance = "occurance"
        case monthly_repeat = "monthly_repeat"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        booking_id = try values.decodeIfPresent(Int.self, forKey: .booking_id)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        earliest_start_time = try values.decodeIfPresent(String.self, forKey: .earliest_start_time)
        latest_start_time = try values.decodeIfPresent(String.self, forKey: .latest_start_time)
        booking_frequency = try values.decodeIfPresent(Int.self, forKey: .booking_frequency)
        backup_date = try values.decodeIfPresent(String.self, forKey: .backup_date)
        back_earliest_start_time = try values.decodeIfPresent(String.self, forKey: .back_earliest_start_time)
        back_latest_start_time = try values.decodeIfPresent(String.self, forKey: .back_latest_start_time)
        repeat_month = try values.decodeIfPresent(Int.self, forKey: .repeat_month)
        repeat_frequency = try values.decodeIfPresent(String.self, forKey: .repeat_frequency)
        booking_method = try values.decodeIfPresent(String.self, forKey: .booking_method)
        ends_on = try values.decodeIfPresent(String.self, forKey: .ends_on)
        occurance = try values.decodeIfPresent(String.self, forKey: .occurance)
        monthly_repeat = try values.decodeIfPresent(String.self, forKey: .monthly_repeat)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }
}

// MARK: - Address
struct AddressResponse : Codable {
    let id : Int?
    let user_id : String?
    let street_address : String?
    let location_type : String?
    let parking : String?
    let accessibility : String?
    let pets : String?
    let notes : String?
    let latitude : String?
    let longitude : String?
    let created_at : String?
    let updated_at : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case user_id = "user_id"
        case street_address = "street_address"
        case location_type = "location_type"
        case parking = "parking"
        case accessibility = "accessibility"
        case pets = "pets"
        case notes = "notes"
        case latitude = "latitude"
        case longitude = "longitude"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        street_address = try values.decodeIfPresent(String.self, forKey: .street_address)
        location_type = try values.decodeIfPresent(String.self, forKey: .location_type)
        parking = try values.decodeIfPresent(String.self, forKey: .parking)
        accessibility = try values.decodeIfPresent(String.self, forKey: .accessibility)
        pets = try values.decodeIfPresent(String.self, forKey: .pets)
        notes = try values.decodeIfPresent(String.self, forKey: .notes)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }
    
}

// MARK: - Provider
struct Provider: Codable {
    let id : Int?
    let user_id : Int?
    let booking_id : Int?
    let provider : Int?
    let created_at : String?
    let updated_at : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case user_id = "user_id"
        case booking_id = "booking_id"
        case provider = "provider"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        booking_id = try values.decodeIfPresent(Int.self, forKey: .booking_id)
        provider = try values.decodeIfPresent(Int.self, forKey: .provider)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }
    
}

// MARK: - Service
struct ServiceResponse: Codable {
    let id : Int?
    let category_id : Int?
    let name : String?
    let description : String?
    let price : Int?
    let status : Int?
    let created_at : String?
    let updated_at : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case category_id = "category_id"
        case name = "name"
        case description = "description"
        case price = "price"
        case status = "status"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        category_id = try values.decodeIfPresent(Int.self, forKey: .category_id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }
}

// MARK: - Recipient
struct Recipient : Codable {
    let id : Int?
    let user_id : Int?
    let booking_id : Int?
    let recipient : Int?
    let first_name : String?
    let last_name : String?
    let mobile : String?
    let email : String?
    let relationship : Int?
    let gender : String?
    let medical_history : Int?
    let additional_info : String?
    let therapist : String?
    let created_at : String?
    let updated_at : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case user_id = "user_id"
        case booking_id = "booking_id"
        case recipient = "recipient"
        case first_name = "first_name"
        case last_name = "last_name"
        case mobile = "mobile"
        case email = "email"
        case relationship = "relationship"
        case gender = "gender"
        case medical_history = "medical_history"
        case additional_info = "additional_info"
        case therapist = "therapist"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        booking_id = try values.decodeIfPresent(Int.self, forKey: .booking_id)
        recipient = try values.decodeIfPresent(Int.self, forKey: .recipient)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        relationship = try values.decodeIfPresent(Int.self, forKey: .relationship)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        medical_history = try values.decodeIfPresent(Int.self, forKey: .medical_history)
        additional_info = try values.decodeIfPresent(String.self, forKey: .additional_info)
        therapist = try values.decodeIfPresent(String.self, forKey: .therapist)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }
    
}

// MARK: - BookingAd
struct BookingAd: Codable {
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
    
    enum CodingKeys: String, CodingKey {
        case id
        case bookingID = "booking_id"
        case userID = "user_id"
        case session
        case duration
        case treatment
        case addon
        case gender
        case addressID = "address_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Duration
struct Duration: Codable {
    let id: Int?
    let timeDuration: Int?
    let description: String?
    let price: Int?
    let createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case timeDuration = "time_duration"
        case description
        case price
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Placeholder for Other Nullable Objects
struct BookingDetails: Codable {
    let id : Int?
    let booking_id : Int?
    let user_id : Int?
    let session : String?
    let duration : String?
    let treatment : String?
    let addon : String?
    let gender : String?
    let address_id : Int?
    let created_at : String?
    let updated_at : String?
    let booking_status : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case booking_id = "booking_id"
        case user_id = "user_id"
        case session = "session"
        case duration = "duration"
        case treatment = "treatment"
        case addon = "addon"
        case gender = "gender"
        case address_id = "address_id"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case booking_status = "booking_status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        booking_id = try values.decodeIfPresent(Int.self, forKey: .booking_id)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        session = try values.decodeIfPresent(String.self, forKey: .session)
        duration = try values.decodeIfPresent(String.self, forKey: .duration)
        treatment = try values.decodeIfPresent(String.self, forKey: .treatment)
        addon = try values.decodeIfPresent(String.self, forKey: .addon)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        address_id = try values.decodeIfPresent(Int.self, forKey: .address_id)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        booking_status = try values.decodeIfPresent(Int.self, forKey: .booking_status)
    }
    
}

struct PaymentResponse : Codable {
    let id : Int?
    let user_id : Int?
    let booking_id : Int?
    let order_id : Int?
    let customer_id : String?
    let intent_key : String?
    let client_secret : String?
    let gateway : String?
    let payment_id : String?
    let country : String?
    let code : String?
    let total : Int?
    let hours_rate : Int?
    let day_rate : Int?
    let parking : Int?
    let notes : String?
    let status : Int?
    let accept_status : Int?
    let suggested_time : String?
    let mail_status : String?
    let payment_methods : String?
    let created_at : String?
    let updated_at : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case user_id = "user_id"
        case booking_id = "booking_id"
        case order_id = "order_id"
        case customer_id = "customer_id"
        case intent_key = "intent_key"
        case client_secret = "client_secret"
        case gateway = "gateway"
        case payment_id = "payment_id"
        case country = "country"
        case code = "code"
        case total = "total"
        case hours_rate = "hours_rate"
        case day_rate = "day_rate"
        case parking = "parking"
        case notes = "notes"
        case status = "status"
        case accept_status = "accept_status"
        case suggested_time = "suggested_time"
        case mail_status = "mail_status"
        case payment_methods = "payment_methods"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        booking_id = try values.decodeIfPresent(Int.self, forKey: .booking_id)
        order_id = try values.decodeIfPresent(Int.self, forKey: .order_id)
        customer_id = try values.decodeIfPresent(String.self, forKey: .customer_id)
        intent_key = try values.decodeIfPresent(String.self, forKey: .intent_key)
        client_secret = try values.decodeIfPresent(String.self, forKey: .client_secret)
        gateway = try values.decodeIfPresent(String.self, forKey: .gateway)
        payment_id = try values.decodeIfPresent(String.self, forKey: .payment_id)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        hours_rate = try values.decodeIfPresent(Int.self, forKey: .hours_rate)
        day_rate = try values.decodeIfPresent(Int.self, forKey: .day_rate)
        parking = try values.decodeIfPresent(Int.self, forKey: .parking)
        notes = try values.decodeIfPresent(String.self, forKey: .notes)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        accept_status = try values.decodeIfPresent(Int.self, forKey: .accept_status)
        suggested_time = try values.decodeIfPresent(String.self, forKey: .suggested_time)
        mail_status = try values.decodeIfPresent(String.self, forKey: .mail_status)
        payment_methods = try values.decodeIfPresent(String.self, forKey: .payment_methods)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }
    
}
struct Booking_ad : Codable {
    let id : Int?
    let booking_id : Int?
    let user_id : Int?
    let session : String?
    let duration : String?
    let treatment : String?
    let addon : String?
    let gender : String?
    let address_id : Int?
    let created_at : String?
    let updated_at : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case booking_id = "booking_id"
        case user_id = "user_id"
        case session = "session"
        case duration = "duration"
        case treatment = "treatment"
        case addon = "addon"
        case gender = "gender"
        case address_id = "address_id"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        booking_id = try values.decodeIfPresent(Int.self, forKey: .booking_id)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        session = try values.decodeIfPresent(String.self, forKey: .session)
        duration = try values.decodeIfPresent(String.self, forKey: .duration)
        treatment = try values.decodeIfPresent(String.self, forKey: .treatment)
        addon = try values.decodeIfPresent(String.self, forKey: .addon)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        address_id = try values.decodeIfPresent(Int.self, forKey: .address_id)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }
    
}

struct Durations : Codable {
    let id : Int?
    let time_duration : Int?
    let description : String?
    let price : Int?
    let created_at : String?
    let updated_at : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case time_duration = "time_duration"
        case description = "description"
        case price = "price"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        time_duration = try values.decodeIfPresent(Int.self, forKey: .time_duration)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }
    
}

struct Booking_status : Codable {
    let status1 : String?
    let status2 : String?
    let status3 : String?
    let status4 : String?
    let status5 : String?
    let status6 : String?
    let status7 : String?
    let status8 : String?
    let status9 : String?
    let status10 : String?
    let status0 : String?

    enum CodingKeys: String, CodingKey {

        case status1 = "1"
        case status2 = "2"
        case status3 = "3"
        case status4 = "4"
        case status5 = "5"
        case status6 = "6"
        case status7 = "7"
        case status8 = "8"
        case status9 = "9"
        case status10 = "10"
        case status0 = "0"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status1 = try values.decodeIfPresent(String.self, forKey: .status1)
        status2 = try values.decodeIfPresent(String.self, forKey: .status2)
        status3 = try values.decodeIfPresent(String.self, forKey: .status3)
        status4 = try values.decodeIfPresent(String.self, forKey: .status4)
        status5 = try values.decodeIfPresent(String.self, forKey: .status5)
        status6 = try values.decodeIfPresent(String.self, forKey: .status6)
        status7 = try values.decodeIfPresent(String.self, forKey: .status7)
        status8 = try values.decodeIfPresent(String.self, forKey: .status8)
        status9 = try values.decodeIfPresent(String.self, forKey: .status9)
        status10 = try values.decodeIfPresent(String.self, forKey: .status10)
        status0 = try values.decodeIfPresent(String.self, forKey: .status0)
    }

}
