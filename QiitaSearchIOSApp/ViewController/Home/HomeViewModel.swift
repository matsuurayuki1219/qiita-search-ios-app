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

    private let useCase: GetQiitaArticleUseCase

    @Published var articles: [QiitaArticleModel] = []

    @Published var isLoading: Bool = false

    private var cancellables = Set<AnyCancellable>()

    private var currentPage: Int = 0

    private var query: String? = nil

    init(useCase: GetQiitaArticleUseCase = GetQiitaArticleUseCase()) {
        self.useCase = useCase
    }

    func loadQiitaArticles(query: String? = nil, isLoadMore: Bool) {
        if isLoadMore {
            currentPage += 1
        } else {
            self.query = query
            articles = []
            currentPage = 1
        }
        Task {
            do {
                isLoading = true
                let data = try await useCase.execute(page: currentPage, perPage: Constant.pageCount, query: self.query)
                articles += data
                isLoading = false
            } catch {
                isLoading = false
            }
        }
    }

}
