//
//  QiitaApiClient.swift
//  QiitaSearchIOSApp
//
//  Created by 松浦裕久 on 2023/10/01.
//

import Foundation

enum QiitaApi {

    static func searchQiitaArticles(page: Int, perPage: Int, query: String?) async throws -> [QiitaArticleEntity] {

        var urlString = "https://qiita.com/api/v2/items/?page=\(page)&per_page=\(perPage)"

        if query != nil { urlString += "&query=\(query!)" }

        guard let url = URL(string: urlString) else { throw ApiError.invalidUrl }

        let request = URLRequest(url: url)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpStatus = response as? HTTPURLResponse else { throw ApiError.responseError }

        if httpStatus.statusCode == 200 {
            do {
                return try JSONDecoder().decode([QiitaArticleEntity].self, from: data)
            } catch {
                throw ApiError.decodeError
            }
        } else {
            throw ApiError.unknown
        }
    }
}
