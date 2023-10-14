//
//  Converter.swift
//  QiitaSearchIOSApp
//
//  Created by 松浦裕久 on 2023/10/01.
//

import Foundation

extension QiitaArticleEntity {
    func toModel() -> QiitaArticleModel {
        return QiitaArticleModel(
            title: title,
            url: url,
            likesCount: likesCount,
            user: user.toModel(),
            tags: tags.map { $0.toModel() },
            createdAt: createdAt.toDate(),
            updatedAt: updatedAt.toDate()
        )
    }
}


extension UserEntity {
    func toModel() -> UserModel {
        return UserModel(
            id: id,
            name: name,
            profileImageUrl: profileImageUrl
        )
    }
}

extension TagEntity {
    func toModel() -> TagModel {
        return TagModel(name: name)
    }
}
