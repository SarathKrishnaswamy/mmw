//
//  NetworkManager.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 20/02/25.
//

import Foundation
import Alamofire

// MARK: - Network Manager
class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        completion: @escaping (Result<T, AFError>) -> Void
    ) {
        // Start Activity Indicator
        ActivityIndicatorManager.shared.startAnimating()
        
        let url = NetworkConfig.baseURL + endpoint
        let encoding: ParameterEncoding = method == .get ? URLEncoding.default : URLEncoding.httpBody
        
        // Retrieve token from SessionManager
        let bearerToken = SessionManger.shared.get(forKey: .userToken) ?? ""
        
        var headers: HTTPHeaders = []
        
        if !bearerToken.isEmpty {
                headers.add(name: "Authorization", value: "Bearer \(bearerToken)")
        }
        
        // Log the URL, Method, Headers, and Parameters
        print("Request URL: \(url)")
        print("HTTP Method: \(method.rawValue)")
        print("Headers: \(headers)")
        if let parameters = parameters {
            print("Parameters: \(parameters)")
        }
        
        // Making the API request
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .validate()
            .responseDecodable(of: T.self) { response in
                // Stop Activity Indicator
                ActivityIndicatorManager.shared.stopAnimating()
                
                // Log the response status code and JSON data
                if let statusCode = response.response?.statusCode {
                    print("Response Status Code: \(statusCode)")
                }
                
                switch response.result {
                case .success(let data):
                    // Convert response data to JSON only if T conforms to Encodable
                    if let encodableData = data as? Encodable,
                       let jsonData = try? JSONEncoder().encode(encodableData),
                       let jsonString = String(data: jsonData, encoding: .utf8) {
                        print("Response JSON: \(jsonString)")
                    } else {
                        print("Failed to encode response data as JSON or T does not conform to Encodable")
                    }
                    completion(.success(data))

                case .failure(let error):
                    // Log failure details and the error
                    print("Error: \(error.localizedDescription)")
                    
                    // Log the raw JSON from the failure response
                    if let data = response.data {
                        let json = String(data: data, encoding: .utf8) ?? "Unable to parse JSON"
                        print("Error JSON: \(json)")
                    }
                    
                    completion(.failure(error))
                }
            }
    }
}

