//
//  BookingReportViewModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 26/02/25.
//

import Foundation
import Alamofire

class BookingReportViewModel {
    // Callbacks for handling success and failure
    var onFetchBookingsSuccess: ((BookingHistoryModel) -> Void)?
    var onFetchBookingsFailure: ((String) -> Void)?
    
    // Properties to store API response data
    var bookings: [Bookings] = []
    // Function to fetch bookings from API
    func fetchBookings() {
        NetworkManager.shared.request(endpoint: NetworkConstants.Endpoints.getBookings, method: .get, parameters: nil) { (result: Result<BookingHistoryModel, AFError>) in
            switch result {
            case .success(let response):
                if let data = response.data {
                    self.bookings = data.bookings ?? []
                    self.onFetchBookingsSuccess?(response)
                } else {
                    self.onFetchBookingsFailure?("No data available")
                }
                
            case .failure(let error):
                self.onFetchBookingsFailure?(error.localizedDescription)
            }
        }
    }
}
