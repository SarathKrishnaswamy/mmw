//
//  PreferenceViewModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 02/03/25.
//

import Foundation
import Alamofire

class PreferenceViewModel {
    var onFetchSuccess: ((GetPreferenceModel) -> Void)?
    var onFetchFailure: ((String) -> Void)?
    
    var preferencesData: MassagePreferencesData?
    var onFetchCustomerSuccess: ((PreferenceModel) -> Void)?
    var onFetchCustomerFailure: ((String) -> Void)?
    
    
    
    var onSaveSuccess: ((SavePreferenceModel) -> Void)?
    var onSaveFailure: ((String) -> Void)?
    
    func fetchCustomerPreferences() {
        NetworkManager.shared.request(endpoint: NetworkConstants.Endpoints.customerSetting, method: .get, parameters: nil) { (result: Result<PreferenceModel, AFError>) in
            switch result {
            case .success(let response):
                self.preferencesData = response.data
                self.onFetchCustomerSuccess?(response)
            case .failure(let error):
                self.onFetchCustomerFailure?(error.localizedDescription)
            }
        }
    }
    
    
    func fetchPreferences() {
        NetworkManager.shared.request(endpoint: NetworkConstants.Endpoints.getPreferenceDetails, method: .get, parameters: nil) { (result: Result<GetPreferenceModel, AFError>) in
            switch result {
            case .success(let response):
                self.onFetchSuccess?(response)
            case .failure(let error):
                self.onFetchFailure?(error.localizedDescription)
            }
        }
    }
    
    
    
    func savePreferences(params: [String: String]) {
        NetworkManager.shared.request(endpoint: NetworkConstants.Endpoints.savePreferenceDetails, method: .post, parameters: params) { (result: Result<SavePreferenceModel, AFError>) in
            switch result {
            case .success(let response):
                self.onSaveSuccess?(response)
            case .failure(let error):
                self.onSaveFailure?(error.localizedDescription)
            }
        }
    }
    
    
    // Method to get the pickerView value from an API response key
    func getPickerValue(from key: String, for category: [String: String]?) -> String {
            return category?[key] ?? "Unknown"
        }
}
