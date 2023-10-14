//
//  QiitaArticleModel.swift
//  QiitaSearchIOSApp
//
//  Created by 松浦裕久 on 2023/10/01.
//

import Foundation

struct QiitaArticleModel {
    let title: String
    let url: String
    let likesCount: Int
    let user: UserModel
    let tags: [TagModel]
    let createdAt: Date
    let updatedAt: Date
}
