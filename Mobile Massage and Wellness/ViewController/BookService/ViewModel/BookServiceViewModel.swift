//
//  BookServiceViewModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 04/03/25.
//

import Foundation
import Alamofire
class BookServiceViewModel{
    var onFetchAddressesSuccess: ((AddressListModel) -> Void)?
    var onFetchAddressesFailure: ((String) -> Void)?
    var addressData: [Address]?
    var addresses:[[String]] = [[]]
    
    var onFetchDurationSuccess: ((DurationResponse) -> Void)?
    var onFetchADurationFailure: ((String) -> Void)?
    
    var onFetchGenderSuccess: ((GenderResponse) -> Void)?
    var onFetchGenderFailure: ((String) -> Void)?
    
    var onFetchAddOnSuccess: ((TreatmentResponse) -> Void)?
    var onFetchAddOnFailure: ((String) -> Void)?
    
    var onFetchServiceSuccess: ((ServicesSettingModel) -> Void)?
    var onFetchServiceFailure: ((String) -> Void)?
    var services: [ServicesResponse]?
    
    var onFetchUserSuccess: ((ProfileModel) -> Void)?
    var onFetchUserFailure: ((String) -> Void)?
    var userData: ProfileData?
    
    
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

    func fetchAddresses() {
        NetworkManager.shared.request(endpoint: NetworkConstants.Endpoints.getAddressList, method: .get, parameters: nil) { (result: Result<AddressListModel, AFError>) in
            switch result {
            case .success(let response):
                self.addressData = response.data
                self.onFetchAddressesSuccess?(response)
                if let addressData = response.data {
                    self.addresses = addressData.map { address in
                        [
                            address.locationType ?? "",
                            address.parking ?? "",
                            address.access ?? "",
                            address.pets ?? ""
                        ]
                    }
                }
            case .failure(let error):
                self.onFetchAddressesFailure?(error.localizedDescription)
            }
        }
    }
    
    func fetchDuration() {
        NetworkManager.shared.request(endpoint: NetworkConstants.Endpoints.durationSetting, method: .get, parameters: nil) { (result: Result<DurationResponse, AFError>) in
            switch result {
            case .success(let response):
                print(response)
                self.onFetchDurationSuccess?(response)
               
            case .failure(let error):
                self.onFetchAddressesFailure?(error.localizedDescription)
            }
        }
    }
    
    
    func fetchAdon() {
        NetworkManager.shared.request(endpoint: NetworkConstants.Endpoints.addOnSetting, method: .get, parameters: nil) { (result: Result<TreatmentResponse, AFError>) in
            switch result {
            case .success(let response):
                self.onFetchAddOnSuccess?(response)
               
            case .failure(let error):
                self.onFetchAddOnFailure?(error.localizedDescription)
            }
        }
    }
    
    func fetchGender() {
        NetworkManager.shared.request(endpoint: NetworkConstants.Endpoints.genderSetting, method: .get, parameters: nil) { (result: Result<GenderResponse, AFError>) in
            switch result {
            case .success(let response):
                self.onFetchGenderSuccess?(response)
               
            case .failure(let error):
                self.onFetchGenderFailure?(error.localizedDescription)
            }
        }
    }
    
    func fetchServicesSetting() {
        NetworkManager.shared.request(endpoint: NetworkConstants.Endpoints.servicesSetting, method: .get, parameters: nil) { (result: Result<ServicesSettingModel, AFError>) in
            switch result {
            case .success(let response):
                self.onFetchServiceSuccess?(response)
                self.services = response.data?.services
            case .failure(let error):
                self.onFetchServiceFailure?(error.localizedDescription)
            }
        }
    }
    
    
    
}

