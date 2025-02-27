/* 
Copyright (c) 2025 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Bookings : Codable {
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
	let provider_name : String?
	let mobile_number : String?
	let email : String?
	let provider_id : Int?
	let location : String?
	let payment_date : String?
	let schedule_date : String?
	let starting_time : String?
	let booking_status : Int?
	let total_amount : Int?
	let payment_status : Int?

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
		case provider_name = "provider_name"
		case mobile_number = "mobile_number"
		case email = "email"
		case provider_id = "provider_id"
		case location = "location"
		case payment_date = "payment_date"
		case schedule_date = "schedule_date"
		case starting_time = "starting_time"
		case booking_status = "booking_status"
		case total_amount = "total_amount"
		case payment_status = "payment_status"
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
		provider_name = try values.decodeIfPresent(String.self, forKey: .provider_name)
		mobile_number = try values.decodeIfPresent(String.self, forKey: .mobile_number)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		provider_id = try values.decodeIfPresent(Int.self, forKey: .provider_id)
		location = try values.decodeIfPresent(String.self, forKey: .location)
		payment_date = try values.decodeIfPresent(String.self, forKey: .payment_date)
		schedule_date = try values.decodeIfPresent(String.self, forKey: .schedule_date)
		starting_time = try values.decodeIfPresent(String.self, forKey: .starting_time)
		booking_status = try values.decodeIfPresent(Int.self, forKey: .booking_status)
		total_amount = try values.decodeIfPresent(Int.self, forKey: .total_amount)
		payment_status = try values.decodeIfPresent(Int.self, forKey: .payment_status)
	}

}