//
//  HomeViewModel.swift
//  QiitaSearchIOSApp
//
//  Created by 松浦裕久 on 2023/10/01.
//

import Foundation
import Combine

@MainActor
class HomeViewModel: ObservableObject {

    private let repository: QiitaRepository

    @Published var articles: [QiitaArticleModel] = []

    @Published var isLoading: Bool = false

    private var cancellables = Set<AnyCancellable>()

    init(repository: QiitaRepository = QiitaRepository()) {
        self.repository = repository
    }

    func searchQiitaArticles(query: String?) {
        Task {
            do {
                isLoading = true
                let data = try await repository.searchQiitaArticles(page: 1, perPage: 20, query: query)
                articles = data
                isLoading = false
            } catch {
                isLoading = false
            }
        }
    }
}
