//
//  VerifyOTPViewModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 22/02/25.
//

import Foundation
import Alamofire

// MARK: - ViewModel
class VerifyOTPViewModel {
    var onMobileOTPSuccess: ((OTPResponseModel) -> Void)?
    var onEmailOTPSuccess: ((OTPResponseModel) -> Void)?
    var onOTPFailure: ((String) -> Void)?
    
    func verifyMobileOTP(countryCode: String, phoneNumber: String) {
        let parameters: [String: Any] = ["code": countryCode, "mobile_number": phoneNumber]
        NetworkManager.shared.request(endpoint: NetworkConstants.Endpoints.mobileOtp, method: .post, parameters: parameters) { (result: Result<OTPResponseModel, AFError>) in
            switch result {
            case .success(let response):
                self.onMobileOTPSuccess?(response)
            case .failure(let error):
                print("Failed: \(error.localizedDescription)")
                self.onOTPFailure?(error.localizedDescription)
            }
        }
    }
    
    func verifyEmailOTP(email: String) {
        let parameters: [String: Any] = ["email": email]
        NetworkManager.shared.request(endpoint: NetworkConstants.Endpoints.emailOtp, method: .post, parameters: parameters) { (result: Result<OTPResponseModel, AFError>) in
            switch result {
            case .success(let response):
                self.onEmailOTPSuccess?(response)
            case .failure(let error):
                print("Failed: \(error.localizedDescription)")
                self.onOTPFailure?(error.localizedDescription)
            }
        }
    }
}
