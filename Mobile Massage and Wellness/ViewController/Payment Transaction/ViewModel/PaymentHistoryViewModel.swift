//
//  PaymentHistoryViewModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 26/02/25.
//

import Foundation
import Alamofire

// MARK: - ViewModel
class PaymentHistoryViewModel {
    var onFetchPaymentHistorySuccess: ((PaymentHistoryModel) -> Void)?
    var onFetchPaymentsHistoryFailure: ((String) -> Void)?
    var paymentData:[PaymentHistory]?
    
    func fetchPaymentHistory() {
        NetworkManager.shared.request(endpoint: NetworkConstants.Endpoints.paymentHistory, method: .get, parameters: nil) { (result: Result<PaymentHistoryModel, AFError>) in
            switch result {
            case .success(let response):
                self.onFetchPaymentHistorySuccess?(response)
                self.paymentData = response.data?.paymentHistories
            case .failure(let error):
                self.onFetchPaymentsHistoryFailure?(error.localizedDescription)
            }
        }
    }
    
}
