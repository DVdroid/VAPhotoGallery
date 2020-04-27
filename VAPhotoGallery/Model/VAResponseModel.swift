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
    var pictures: [VAPhoto]?

    enum CodingKeys: String, CodingKey {
        case pictureCollectionTitle = "title"
        case pictures = "rows"
    }
}

struct VAPhoto: Codable {
    var title  : String?
    var imageUrl : String?
    var description : String?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case imageUrl = "imageHref"
    }
}
