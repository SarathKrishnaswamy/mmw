/* 
Copyright (c) 2025 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Metadata : Codable {
	let providers : [Providers]?
	let statuses : Statuses?
	let booking_status : BookingStatus?
	let payment_status : PaymentStatus?
	let locations : [Locations]?
	let services : [Services]?

	enum CodingKeys: String, CodingKey {

		case providers = "providers"
		case statuses = "statuses"
		case booking_status = "booking_status"
		case payment_status = "payment_status"
		case locations = "locations"
		case services = "services"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		providers = try values.decodeIfPresent([Providers].self, forKey: .providers)
		statuses = try values.decodeIfPresent(Statuses.self, forKey: .statuses)
		booking_status = try values.decodeIfPresent(BookingStatus.self, forKey: .booking_status)
		payment_status = try values.decodeIfPresent(PaymentStatus.self, forKey: .payment_status)
		locations = try values.decodeIfPresent([Locations].self, forKey: .locations)
		services = try values.decodeIfPresent([Services].self, forKey: .services)
	}

}
