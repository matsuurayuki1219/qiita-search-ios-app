//
//  QiitaRepository.swift
//  QiitaSearchIOSApp
//
//  Created by 松浦裕久 on 2023/10/01.
//

import Foundation

class QiitaRepository {

    func searchQiitaArticles(page: Int, perPage: Int, query: String?) async throws -> [QiitaArticleModel] {
        return try await QiitaApi.searchQiitaArticles(page: page, perPage: perPage, query: query).map { $0.toModel() }
    }
    
}
