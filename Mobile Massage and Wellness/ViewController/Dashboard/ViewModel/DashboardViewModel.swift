//
//  DashboardViewModel.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 23/02/25.
//

import Foundation
import Alamofire

// MARK: - DashboardViewModel
class DashboardViewModel {
    var onDashboardDataSuccess: ((DashboardModel) -> Void)?
    var onDashboardDataFailure: ((String) -> Void)?
    
    func fetchDashboardData() {
        NetworkManager.shared.request(endpoint: NetworkConstants.Endpoints.dashboard, method: .get, parameters: nil) { (result: Result<DashboardModel, AFError>) in
            switch result {
            case .success(let response):
                self.onDashboardDataSuccess?(response)
            case .failure(let error):
                print("Fetching dashboard data failed: \(error.localizedDescription)")
                self.onDashboardDataFailure?(error.localizedDescription)
            }
        }
    }
}
