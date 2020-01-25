//
//  ArticleModel.swift
//  Media
//
//  Created by 川井淳矢 on 2020/01/26.
//  Copyright © 2020 川井淳矢. All rights reserved.
//

import Foundation

struct Article: Codable {
    let title: String
    let url:   String
    let user:  User
}

struct User: Codable{
    let name:              String
    let profile_image_url: String
}
