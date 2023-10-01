//
//  UserEntity.swift
//  QiitaSearchIOSApp
//
//  Created by 松浦裕久 on 2023/10/01.
//

import Foundation

struct UserEntity: Codable {
    let id: String
    let name: String
    let profileImageUrl: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case profileImageUrl = "profile_image_url"
    }
}
