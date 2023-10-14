//
//  QiitaArticleView.swift
//  QiitaSearchIOSApp
//
//  Created by 松浦裕久 on 2023/10/14.
//

import Foundation
import UIKit
import Nuke
import NukeExtensions
import TagListView

class QiitaArticleView: UIView {

    var article: QiitaArticleModel? {
        didSet {
            guard let article = article else { return }
            update(article: article)
        }
    }

    // MARK: - Subview

    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .regular14
        label.textColor = .black10
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var createdAtLabel: UILabel = {
        let label = UILabel()
        label.font = .regular14
        label.textColor = .gray50
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .bold18
        label.textColor = .black10

        return label
    }()

    private lazy var favoriteImageView = {
        let image = UIImage(systemName: "heart.fill")
        let imageView = UIImageView()
        imageView.image = image
        imageView.tintColor = .yellow90
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var favoriteLabel = {
        let label = UILabel()
        label.font = .regular16
        label.textColor = .black10
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var tagListView = {
        let view = TagListView()
        view.tagBackgroundColor = .gray40
        view.textFont = .regular12
        view.textColor = .black10
        view.cornerRadius = 4
        view.marginX = 8
        view.marginY = 8
        view.paddingX = 8
        view.paddingY = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        layer.cornerRadius = 12

        addSubview(profileImage)
        addSubview(userNameLabel)
        addSubview(createdAtLabel)
        addSubview(titleLabel)
        addSubview(favoriteImageView)
        addSubview(favoriteLabel)
        addSubview(tagListView)

        setConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Constraint

private extension QiitaArticleView {

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
        titleLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true

        tagListView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        tagListView.leftAnchor.constraint(equalTo: profileImage.leftAnchor).isActive = true
        tagListView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true

        favoriteImageView.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor).isActive = true
        favoriteImageView.topAnchor.constraint(equalTo: tagListView.bottomAnchor, constant: 12).isActive = true
        favoriteImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true

        favoriteLabel.leadingAnchor.constraint(equalTo: favoriteImageView.trailingAnchor, constant: 12).isActive = true
        favoriteLabel.topAnchor.constraint(equalTo: favoriteImageView.topAnchor).isActive = true
        favoriteLabel.bottomAnchor.constraint(equalTo: favoriteImageView.bottomAnchor).isActive = true

    }

}

// MARK: - Private

private extension QiitaArticleView {

    func update(article: QiitaArticleModel) {

        // imageView
        guard let url = URL(string: article.user.profileImageUrl) else { return }
        NukeExtensions.loadImage(with: url, into: profileImage.roundCorner())

        // label
        userNameLabel.text = article.user.id
        createdAtLabel.text = article.createdAt
        titleLabel.text = article.title
        favoriteLabel.text = String(article.likesCount)

        // tags
        tagListView.removeAllTags()
        tagListView.addTags(article.tags.map{ $0.name})

        setNeedsLayout()
    }

}
