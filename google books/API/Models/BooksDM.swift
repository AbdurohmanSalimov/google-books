//
//  BooksDM.swift
//  google books
//
//  Created by Azizbek Salimov on 11/01/23.
//

import Foundation
import SwiftyJSON

struct FavoriteBookDM {
    let id: String
    let books: [BookDM]
}

struct BookDM {
    let id: String
    let volumeInfo: VolumeInfo
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.volumeInfo = VolumeInfo(json: json["volumeInfo"] )
    }
}

struct VolumeInfo {
    let title: String
    let authors: [String]
    let description: String
    let imageLinks: ImageDM
    let infoLink: String
    
    init(json: JSON) {
        self.title = json["title"].stringValue
        self.authors = json["authors"].arrayValue.map {$0.stringValue }
        self.description = json["description"].stringValue
        self.imageLinks = ImageDM(json: json["imageLinks"])
        self.infoLink = json["infoLink"].stringValue
    }
}

struct ImageDM {
    let thumbnail: String?
    let smallThumbnail: String?
    
    init(json: JSON) {
        self.smallThumbnail = json["smallThumbnail"].stringValue
        self.thumbnail = json["thumbnail"].stringValue
    }
}
