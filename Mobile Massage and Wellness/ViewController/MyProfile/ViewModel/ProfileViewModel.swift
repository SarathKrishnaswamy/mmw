//
//  ProfileViewModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 27/02/25.
//

import Foundation
import Alamofire

class ProfileViewModel {
    var onFetchUserSuccess: ((ProfileModel) -> Void)?
    var onFetchUserFailure: ((String) -> Void)?
    var userData: ProfileData?
    
    var onSaveUserSuccess: ((AddressUpdateModel) -> Void)?
    var onSaveUserFailure: ((String) -> Void)?
    
    func fetchUser() {
        NetworkManager.shared.request(endpoint: NetworkConstants.Endpoints.getCustomerDetails, method: .get, parameters: nil) { (result: Result<ProfileModel, AFError>) in
            switch result {
            case .success(let response):
                self.onFetchUserSuccess?(response)
                self.userData = response.data
            case .failure(let error):
                self.onFetchUserFailure?(error.localizedDescription)
            }
        }
    }
    
    func saveUser(params:[String:String]) {
        NetworkManager.shared.request(endpoint: NetworkConstants.Endpoints.saveCustomerDetails, method: .post, parameters: params) { (result: Result<AddressUpdateModel, AFError>) in
            switch result {
            case .success(let response):
                self.onSaveUserSuccess?(response)
            case .failure(let error):
                self.onSaveUserFailure?(error.localizedDescription)
            }
        }
    
    }
}
