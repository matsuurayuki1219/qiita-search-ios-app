//
//  HomeViewController+CellView.swift
//  QiitaSearchIOSApp
//
//  Created by 松浦裕久 on 2023/10/01.
//

import Foundation
import UIKit
import Nuke
import NukeExtensions

extension HomeViewController {

    class QiitaArticle: UIView {

        // MARK: - Subview

        private lazy var profileImage: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()

        private lazy var userNameLabel: UILabel = {
            let label = UILabel()
            label.font = .regular14
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        private lazy var createdAtLabel: UILabel = {
            let label = UILabel()
            label.font = .regular14
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.font = .regular18
            return label
        }()

        private lazy var favoriteImageView = {
            let image = UIImage(systemName: "paperclip")
            let imageView = UIImageView()
            imageView.image = image
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()

        private lazy var favoriteLabel = {
            let label = UILabel()
            label.font = .regular16
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        // MARK: - Init

        override init(frame: CGRect) {
            super.init(frame: frame)

            backgroundColor = .cyan
            layer.cornerRadius = 12

            addSubview(profileImage)
            addSubview(userNameLabel)
            addSubview(createdAtLabel)
            addSubview(titleLabel)
            addSubview(favoriteImageView)
            addSubview(favoriteLabel)

            setConstraint()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        // MARK: - Update

        func update(article: QiitaArticleModel?) {
            guard let article = article else { return }
            guard let url = URL(string: article.user.profileImageUrl) else { return }
            NukeExtensions.loadImage(with: url, into: profileImage.roundCorner())
            userNameLabel.text = article.user.name
            createdAtLabel.text = article.createdAt
            titleLabel.text = article.title
            favoriteLabel.text = String(article.likesCount)
        }

    }

}

// MARK: - Private

private extension HomeViewController.QiitaArticle {

    func setConstraint() {

        profileImage.widthAnchor.constraint(equalToConstant: 48).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 48).isActive = true
        profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        profileImage.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true

        userNameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 12).isActive = true
        userNameLabel.topAnchor.constraint(equalTo: profileImage.topAnchor).isActive = true
        userNameLabel.bottomAnchor.constraint(equalTo: createdAtLabel.topAnchor).isActive = true

        createdAtLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor).isActive = true
        createdAtLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor).isActive = true
        createdAtLabel.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor).isActive = true

        titleLabel.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 12).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true

        favoriteImageView.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor).isActive = true
        favoriteImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true

        favoriteLabel.leadingAnchor.constraint(equalTo: favoriteImageView.trailingAnchor, constant: 12).isActive = true
        favoriteLabel.topAnchor.constraint(equalTo: favoriteImageView.topAnchor).isActive = true
        favoriteLabel.bottomAnchor.constraint(equalTo: favoriteImageView.bottomAnchor).isActive = true
        
    }

}
