//
//  AddressListViewModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 26/02/25.
//

import Foundation
import Alamofire

class AddressViewModel {
    var onFetchAddressesSuccess: ((AddressListModel) -> Void)?
    var onFetchAddressesFailure: ((String) -> Void)?
    var addressData: [Address]?
    var addresses:[[String]] = [[]]
    
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
    
    
    

    

}
