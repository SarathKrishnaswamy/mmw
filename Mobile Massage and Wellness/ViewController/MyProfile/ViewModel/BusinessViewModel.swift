//
//  BusinessViewModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 28/02/25.
//

import Foundation
import Alamofire

class BusinessViewModel {
    var onFetchBusinessSuccess: ((BusinessModel) -> Void)?
    var onFetchBusinessFailure: ((String) -> Void)?
   
    
    var onSaveBusinessSuccess: ((AddressUpdateModel) -> Void)?
    var onSaveBusinessFailure: ((String) -> Void)?
    
    func fetchBusiness() {
        NetworkManager.shared.request(endpoint: NetworkConstants.Endpoints.getBusinessDetails, method: .get, parameters: nil) { (result: Result<BusinessModel, AFError>) in
            switch result {
            case .success(let response):
                self.onFetchBusinessSuccess?(response)
            case .failure(let error):
                self.onFetchBusinessFailure?(error.localizedDescription)
            }
        }
    }
    
    func saveUser(params:[String:String]) {
        NetworkManager.shared.request(endpoint: NetworkConstants.Endpoints.saveBusinessDetails, method: .post, parameters: params) { (result: Result<AddressUpdateModel, AFError>) in
            switch result {
            case .success(let response):
                self.onSaveBusinessSuccess?(response)
            case .failure(let error):
                self.onSaveBusinessFailure?(error.localizedDescription)
            }
        }
    
    }
}

