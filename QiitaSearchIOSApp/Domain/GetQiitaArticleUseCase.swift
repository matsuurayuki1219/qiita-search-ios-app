//
//  GetQiitaArticleUseCase.swift
//  QiitaSearchIOSApp
//
//  Created by 松浦裕久 on 2023/10/14.
//

import Foundation

class GetQiitaArticleUseCase {

    private let repository: QiitaRepository

    init(repository: QiitaRepository = QiitaRepository()) {
        self.repository = repository
    }

    func execute(page: Int, perPage: Int, query: String?) async throws -> [QiitaArticleModel] {
        return try await repository.searchQiitaArticles(page: page, perPage: perPage, query: query)
    }

}
