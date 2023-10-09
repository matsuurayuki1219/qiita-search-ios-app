//
//  QiitaApiClient.swift
//  QiitaSearchIOSApp
//
//  Created by 松浦裕久 on 2023/10/01.
//

import Foundation
import Combine

class QiitaApiClient {

    static let shared = QiitaApiClient()

    private init() {}

    func searchQiitaArticles(page: Int, perPage: Int, query: String?) -> AnyPublisher<[QiitaArticleEntity], Error> {
        var baseURL = "https://qiita.com/api/v2/items/?page=\(page)&per_page=\(perPage)"
        if query != nil {
            baseURL += "&query=\(query!)"
        }
        let url = URL(string: baseURL)!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [QiitaArticleEntity].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

}
