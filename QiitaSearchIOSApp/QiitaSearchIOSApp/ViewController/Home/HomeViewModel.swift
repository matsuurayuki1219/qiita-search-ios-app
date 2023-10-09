//
//  HomeViewModel.swift
//  QiitaSearchIOSApp
//
//  Created by 松浦裕久 on 2023/10/01.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {

    private let repository: QiitaRepository

    @Published var articles: [QiitaArticleModel] = []

    private var cancellables = Set<AnyCancellable>()

    init(repository: QiitaRepository = QiitaRepository()) {
        self.repository = repository
    }

    func searchQiitaArticles(query: String?) {
        repository.searchQiitaArticles(page: 1, perPage: 20, query: query)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    break
                }
            } receiveValue: { articles in
                self.articles = articles
            }.store(in: &cancellables)
    }
}
