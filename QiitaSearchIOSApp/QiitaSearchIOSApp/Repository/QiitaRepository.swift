//
//  QiitaRepository.swift
//  QiitaSearchIOSApp
//
//  Created by 松浦裕久 on 2023/10/01.
//

import Foundation
import Combine

class QiitaRepository {

    func searchQiitaArticles(page: Int, perPage: Int) -> AnyPublisher<QiitaArticleModel, Error> {
        return QiitaApiClient.shared.searchQiitaArticles(page: page, perPage: perPage)
            .map { $0.toModel() }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
