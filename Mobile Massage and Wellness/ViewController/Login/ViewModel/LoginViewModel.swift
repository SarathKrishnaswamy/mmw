//
//  LoginViewModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 20/02/25.
//

import Foundation
import Alamofire

// MARK: - ViewModel
class LoginViewModel {
    var onLoginSuccess: ((LoginResponseModel) -> Void)?
    var onLoginFailure: ((String) -> Void)?
        
    func login(username: String, password: String) {
        let parameters: [String: Any] = ["email": username, "password": password]
        NetworkManager.shared.request(endpoint: NetworkConstants.Endpoints.login, method: .post, parameters: parameters) { (result: Result<LoginResponseModel, AFError>) in
            switch result {
            case .success(let response):
                print("Login Success: \(response.token)")
                SessionManger.shared.save(value: response.token, forKey: .userToken)
                self.onLoginSuccess?(response)
            case .failure(let error):
                print("Login Failed: \(error.localizedDescription)")
                self.onLoginFailure?(error.localizedDescription)
            }
        }
    }
}
