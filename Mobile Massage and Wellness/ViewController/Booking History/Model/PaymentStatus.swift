/* 
Copyright (c) 2025 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct PaymentStatus: Codable {
    let status0: String?
    let status1: String?
    let status2: String?
    let status3: String?
    let status4: String?
    let status5: String?

    enum CodingKeys: String, CodingKey {
        case status0 = "0"
        case status1 = "1"
        case status2 = "2"
        case status3 = "3"
        case status4 = "4"
        case status5 = "5"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status0 = try container.decodeIfPresent(String.self, forKey: .status0)
        status1 = try container.decodeIfPresent(String.self, forKey: .status1)
        status2 = try container.decodeIfPresent(String.self, forKey: .status2)
        status3 = try container.decodeIfPresent(String.self, forKey: .status3)
        status4 = try container.decodeIfPresent(String.self, forKey: .status4)
        status5 = try container.decodeIfPresent(String.self, forKey: .status5)
    }
}
