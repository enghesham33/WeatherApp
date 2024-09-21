//
//  NetworkLayer.swift
//  WeatherApp
//
//  Created by Mayar Khaled on 21/09/2024.
//

import Foundation
import Alamofire

class NetworkLayer {
    
    public static let shared = NetworkLayer()
    
    func makeRequest(endPoint: Endpoint, method: HTTPMethod, parameters: [String : Any]? = nil, successHandler: @escaping (Data) -> Void, failedHandler: @escaping (String?) -> Void) {
        AF.request(endPoint.url, method: method, parameters: parameters).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {
                    failedHandler("Error in response")
                    return
                }
                successHandler(data)
                break
                
            case .failure(let error):
                failedHandler(error.localizedDescription)
                break
            }
        }
    }
}
