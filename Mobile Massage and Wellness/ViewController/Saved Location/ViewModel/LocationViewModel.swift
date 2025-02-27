//
//  LocationViewModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 26/02/25.
//

import Foundation
import Alamofire

class LocationViewModel {
    var onFetchLocationsSuccess: ((LocationResponse) -> Void)?
    var onFetchLocationsFailure: ((String) -> Void)?
    var locationData: LocationData?
    var locations: [[String]] = [[]]
    
    var onFetchAddressesViewSuccess: ((AddressModel) -> Void)?
    var onFetchAddressesViewFailure: ((String) -> Void)?
    var addressViewData: [Address]?
    
    var onFetchAddressesUpdateSuccess: ((AddressUpdateModel) -> Void)?
    var onFetchAddressesUpdateFailure: ((String) -> Void)?
    
    var onFetchAddressesStoreSuccess: ((AddressUpdateModel) -> Void)?
    var onFetchAddressesStoreFailure: ((String) -> Void)?
    
    
    var onDeleteAddressSuccess: ((AddressUpdateModel) -> Void)?
    var onDeleteAddressFailure: ((String) -> Void)?
    
    
    func fetchLocations() {
        NetworkManager.shared.request(endpoint: NetworkConstants.Endpoints.locationSettings, method: .get, parameters: nil) { (result: Result<LocationResponse, AFError>) in
            switch result {
            case .success(let response):
                self.locationData = response.data
                self.onFetchLocationsSuccess?(response)
                
                if let data = response.data {
                    self.locations = [
                        data.locationType ?? [],
                        data.parking ?? [],
                        data.haveStairs ?? [],
                        data.havePets ?? []
                    ]
                }
            case .failure(let error):
                self.onFetchLocationsFailure?(error.localizedDescription)
            }
        }
    }
    
    func fetchAddressesView(id:String) {
        let endpoint = NetworkConstants.Endpoints.addressView + "\(id)"
        NetworkManager.shared.request(endpoint: endpoint, method: .get, parameters: nil) { (result: Result<AddressModel, AFError>) in
            switch result {
            case .success(let response):
                self.addressViewData = response.addresses
                self.onFetchAddressesViewSuccess?(response)
                
            case .failure(let error):
                self.onFetchAddressesViewFailure?(error.localizedDescription)
            }
        }
    }
    
    func updateAddressView(id:String, parameters: [String: Any]) {
        let endpoint = NetworkConstants.Endpoints.addressUpdate + "\(id)"
        NetworkManager.shared.request(endpoint: endpoint, method: .post, parameters: parameters) { (result: Result<AddressUpdateModel, AFError>) in
            switch result {
            case .success(let response):
                self.onFetchAddressesUpdateSuccess?(response)
            case .failure(let error):
                self.onFetchAddressesUpdateFailure?(error.localizedDescription)
            }
        }
    }
    
    
    func addAddressView(parameters: [String: Any]) {
        let endpoint = NetworkConstants.Endpoints.addressStore
        NetworkManager.shared.request(endpoint: endpoint, method: .post, parameters: parameters) { (result: Result<AddressUpdateModel, AFError>) in
            switch result {
            case .success(let response):
                self.onFetchAddressesStoreSuccess?(response)
            case .failure(let error):
                self.onFetchAddressesStoreFailure?(error.localizedDescription)
            }
        }
    }
    
    
    func deleteAddressView(id:String) {
        let endpoint = NetworkConstants.Endpoints.addressDelete + "\(id)"
        NetworkManager.shared.request(endpoint: endpoint, method: .delete, parameters: nil) { (result: Result<AddressUpdateModel, AFError>) in
            switch result {
            case .success(let response):
                self.onDeleteAddressSuccess?(response)
                
            case .failure(let error):
                self.onDeleteAddressFailure?(error.localizedDescription)
            
            }
        }
    }
    
}
