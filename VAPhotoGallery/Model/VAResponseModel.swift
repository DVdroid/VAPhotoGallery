//
//  VAResponseModel.swift
//  VAPhotoModel
//
//  Created by Anuj Rai on 27/04/20.
//  Copyright © 2020 Vikash Anand. All rights reserved.
//

import Foundation

struct VAResponseModel: Codable {
    let pictureCollectionTitle: String?
    var photos: [VAPhoto]?

    enum CodingKeys: String, CodingKey {
        case pictureCollectionTitle = "title"
        case photos = "rows"
    }
}

struct VAPhoto: Codable {
    var title  : String?
    var imageUrl : String?
    var description : String?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case imageUrl = "imageHref"
        case description = "description"
    }
}
