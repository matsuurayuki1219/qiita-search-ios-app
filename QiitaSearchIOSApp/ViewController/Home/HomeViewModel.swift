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

    private let getArticles: GetQiitaArticleUseCase

    @Published var articles: [QiitaArticleModel] = []

    @Published var isLoading: Bool = false

    private var cancellables = Set<AnyCancellable>()

    init(useCase: GetQiitaArticleUseCase = GetQiitaArticleUseCase()) {
        self.getArticles = useCase
    }

    func searchQiitaArticles(query: String?) {
        Task {
            do {
                isLoading = true
                let data = try await getArticles.execute(page: 1, perPage: 20, query: query)
                articles = data
                isLoading = false
            } catch {
                isLoading = false
            }
        }
    }
}
