//
//  HomeViewController+ArticleCell.swift
//  QiitaSearchIOSApp
//
//  Created by 松浦裕久 on 2023/10/07.
//

import Foundation
import UIKit

extension HomeViewController {

    class QiitaArticleCell: UITableViewCell {

        static let id = "article_cell"

        var article: QiitaArticleModel? {
            didSet {
                articleView.update(article: article)
            }
        }

        lazy var articleView = {
            let view = QiitaArticleView()
            return view
        }()

    }
}
