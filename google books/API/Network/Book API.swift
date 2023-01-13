//
//  Book API.swift
//  google books
//
//  Created by Azizbek Salimov on 11/01/23.
//


import Foundation
import SwiftyJSON
import Alamofire

final class BookAPI {
    
    static func getBooks(keyWord: String, completion: @escaping ([BookDM]?) -> Void) {
        
        let params: Parameters = [
            "q" : keyWord,
            "key": Constants.apiKey,
        ]
        
        Request.shared.requestBooks(method: .get, params: params) { data in
            guard let dataCheked = data else { completion(nil); return }
            if dataCheked["totalItems"] == 0 {
                completion(nil)
                return
            } else {
                let books = dataCheked["items"].arrayValue.map { json in BookDM(json: json) }
                completion(books)
            }
        }
       
        
    }
    
    static func getFavoriteBooks(bookId: String, completion: @escaping (BookDM?) -> Void) {
        
        let params: Parameters = [
            "key": Constants.apiKey
        ]
        Request.shared.getSpecificBook(id: bookId, method: .get, params: params) { data in
            guard let dataCheked = data else { completion(nil); return }
                let books = BookDM(json: dataCheked)
                completion(books)
           
        }
       
       
        
    }
    
}


