//
//  ForgotPasswordViewModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 23/02/25.
//

import Foundation
import Alamofire

// MARK: - ViewModel
class ForgotPasswordViewModel {
    var onForgotPasswordSuccess: ((ForgotPasswordModel) -> Void)?
    var onForgotPasswordailure: ((String) -> Void)?
        
    func forgotPassword(email: String) {
        let parameters: [String: Any] = ["email": email]
        NetworkManager.shared.request(endpoint: NetworkConstants.Endpoints.forgotPassword, method: .post, parameters: parameters) { (result: Result<ForgotPasswordModel, AFError>) in
            switch result {
            case .success(let response):
                self.onForgotPasswordSuccess?(response)
            case .failure(let error):
                self.onForgotPasswordailure?(error.localizedDescription)
            }
        }
    }
}
