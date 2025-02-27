//
//  TicketViewModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 25/02/25.
//

import Foundation
import Alamofire

// MARK: - ViewModel
class TicketViewModel {
    var onFetchTicketsSuccess: ((TicketModel) -> Void)?
    var onFetchTicketsFailure: ((String) -> Void)?
    var ticketData:[TicketData]?
    
    var onFetchStoreTickets: ((storeTicketModel) -> Void)?
    var onFetchStoreTicketsFailure: ((String) -> Void)?
    
    
    
    func fetchTickets() {
        NetworkManager.shared.request(endpoint: NetworkConstants.Endpoints.getTickets, method: .get, parameters: nil) { (result: Result<TicketModel, AFError>) in
            switch result {
            case .success(let response):
                self.onFetchTicketsSuccess?(response)
                self.ticketData = response.data
            case .failure(let error):
                self.onFetchTicketsFailure?(error.localizedDescription)
            }
        }
    }
    
    
    func storeTickets(title:String, desc:String, status:String, priority:String) {
        let param = ["title":title, "description":desc, "status":status, "priority":priority]
        NetworkManager.shared.request(endpoint: NetworkConstants.Endpoints.storeTickets, method: .post, parameters: param) { (result: Result<storeTicketModel, AFError>) in
            switch result {
            case .success(let response):
                self.onFetchStoreTickets?(response)
            case .failure(let error):
                self.onFetchStoreTicketsFailure?(error.localizedDescription)
            }
        }
    }
}
