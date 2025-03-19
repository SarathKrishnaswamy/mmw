//
//  MyAppointmentsViewModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 04/03/25.
//

import Foundation
import Alamofire

class MyAppointmentsViewModel {
    var onFetchAppointmentsSuccess: ((MyAppointmentsModel) -> Void)?
    var onFetchAppointmentsFailure: ((String) -> Void)?
    var upcomingBookings: [Booking]?
    var previousBookings: [Booking]?
    
    var onFetchBookingSuccess: ((ViewBookingModel) -> Void)?
    var onFetchBookingFailure: ((String) -> Void)?
    
    var onFetchCancelBookingSuccess: ((SavePreferenceModel) -> Void)?
    var onFetchCancelBookingFailure: ((String) -> Void)?
    
    
    func fetchAppointments() {
        NetworkManager.shared.request(endpoint: NetworkConstants.Endpoints.getMyAppointments , method: .get, parameters: nil) { (result: Result<MyAppointmentsModel, AFError>) in
            switch result {
            case .success(let response):
                self.upcomingBookings = response.data?.upcomingBookings
                self.previousBookings = response.data?.previousBookings
                self.onFetchAppointmentsSuccess?(response)
            case .failure(let error):
                self.onFetchAppointmentsFailure?(error.localizedDescription)
            }
        }
    }
    
    
    
    
    func fetchBookingDetails(id:String) {
        NetworkManager.shared.request(endpoint: NetworkConstants.Endpoints.viewBooking+id, method: .get, parameters: nil) { (result: Result<ViewBookingModel, AFError>) in
            switch result {
            case .success(let response):
                self.onFetchBookingSuccess?(response)
            case .failure(let error):
                self.onFetchBookingFailure?(error.localizedDescription)
            }
        }
    }
    
    
    func cancelBooking(params:[String:String]){
        NetworkManager.shared.request(endpoint: NetworkConstants.Endpoints.cancelBooking, method: .post, parameters: params) { (result: Result<SavePreferenceModel, AFError>) in
            switch result {
            case .success(let response):
                self.onFetchCancelBookingSuccess?(response)
            case .failure(let error):
                self.onFetchCancelBookingFailure?(error.localizedDescription)
            }
        }
    }
}
