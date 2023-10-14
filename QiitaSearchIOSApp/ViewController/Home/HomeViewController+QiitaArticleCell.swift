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

        // MARK: - Variables

        static let id = "article_cell"

        var article: QiitaArticleModel? {
            didSet {
                guard let article = article else { return }
                articleView.article = article
                setNeedsLayout()
            }
        }

        // MARK: - Subview

        lazy var articleView = {
            let view = QiitaArticleView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()

        // MARK: - Init

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)

            addSubview(articleView)

            backgroundColor = .clear

            articleView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            articleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
            articleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
            articleView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
}
