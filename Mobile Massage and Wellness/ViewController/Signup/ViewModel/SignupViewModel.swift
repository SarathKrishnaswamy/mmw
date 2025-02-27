//
//  SignupViewModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 23/02/25.
//

import Foundation
import Alamofire

// MARK: - SignupViewModel
class SignupViewModel {
    var onSignupSuccess: ((UserSignUpModel) -> Void)?
    var onSignupFailure: ((String) -> Void)?
    
    func signup(firstName: String, lastName: String, gender: String, mobile: String, email: String, password: String, address: String, toc: Bool) {
        let parameters: [String: Any] = [
            "first_name": firstName,
            "last_name": lastName,
            "gender": gender,
            "mobile": mobile,
            "email": email,
            "password": password,
            "password_confirmation": password,
            "address": address,
            "toc": toc
        ]
        
        NetworkManager.shared.request(endpoint: NetworkConstants.Endpoints.signup, method: .post, parameters: parameters) { (result: Result<UserSignUpModel, AFError>) in
            switch result {
            case .success(let response):
                self.onSignupSuccess?(response)
            case .failure(let error):
                print("Signup failed: \(error.localizedDescription)")
                self.onSignupFailure?(error.localizedDescription)
            }
        }
    }
}
