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

    func searchQiitaArticles(page: Int, perPage: Int) -> AnyPublisher<[QiitaArticleEntity], Error> {
        let url = URL(string: "https://qiita.com/api/v2/items/?page=\(page)&per_page=\(perPage)")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [QiitaArticleEntity].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

}
