//
//  Request.swift
//  google books
//
//  Created by Azizbek Salimov on 11/01/23.
//

import Alamofire
import SwiftyJSON
import Foundation


typealias CompletionJSON = (JSON?) -> ()


class Request {
    static let shared = Request()
    
    private var headers: HTTPHeaders = [
//        "Host": "<calculated when request is sent>"
    ]
    
    func requestBooks(method: HTTPMethod, params: Parameters, encoding: ParameterEncoding = URLEncoding.default, completion: @escaping CompletionJSON ) {
        AF.request( Constants.baseUrl, method: method, parameters: params, encoding: encoding, headers: headers).response {
            response in

            guard let data = response.data else { completion(nil); return }
            let jsonData = JSON(data)
            completion(jsonData)
        
        }
    
    }
    
    func getSpecificBook(id: String, method: HTTPMethod, params: Parameters, encoding: ParameterEncoding = URLEncoding.default, completion: @escaping CompletionJSON ) {
        AF.request( Constants.baseUrl + "/\(id)", method: method, parameters: params, encoding: encoding, headers: headers).response {
            response in
            guard let data = response.data else { completion(nil); return }
            let jsonData = JSON(data)
            completion(jsonData)
        
        }
    
    }
    
    



}


