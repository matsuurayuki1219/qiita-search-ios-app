//
//  HomeViewController+CellView.swift
//  QiitaSearchIOSApp
//
//  Created by 松浦裕久 on 2023/10/01.
//

import Foundation
import UIKit

extension HomeViewController {

    class QiitaArticleView: UIView {

        // MARK: - Subview

        private lazy var profileImage: UIImageView = {
            let imageView = UIImageView()
            return imageView
        }()

        private lazy var userNameLabel: UILabel = {
            let label = UILabel()
            return label
        }()

        private lazy var createdAtLabel: UILabel = {
            let label = UILabel()
            return label
        }()

        private lazy var titleLabel: UILabel = {
            let label = UILabel()
            return label
        }()

        private lazy var favoriteImageView = {
            let imageView = UIImageView()
            return imageView
        }()

        private lazy var favoriteLabel = {
            let label = UILabel()
            return label
        }()

        // MARK: - Init

        override init(frame: CGRect) {
            super.init(frame: frame)
            addSubview(profileImage)
            addSubview(userNameLabel)
            addSubview(createdAtLabel)
            addSubview(titleLabel)
            addSubview(favoriteImageView)
            addSubview(favoriteLabel)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        // MARK: - View Lifecycle

        override func layoutSubviews() {
            super.layoutSubviews()
            initProfileImage()
            initUserNameLabel()
            initCreatedAtLabel()
            initTitleLabel()
            initFavoriteImageView()
            initFavoriteLabel()
        }

    }
    
}

// MARK: - Private

extension HomeViewController.QiitaArticleView {

    private func initProfileImage() {
        profileImage.frame = CGRect(x: 20, y: 20, width: 48, height: 48)
    }

    private func initUserNameLabel() {
        let x = profileImage.frame.width + profileImage.frame.origin.x
        let w = frame.width - x - 20
        userNameLabel.frame = CGRect(x: x, y: 20, width: w, height: 40)
    }

    private func initCreatedAtLabel() {
        let x = profileImage.frame.width + profileImage.frame.origin.x
        let w = frame.width - x - 20
        userNameLabel.frame = CGRect(x: x, y: 20, width: w, height: 40)
    }

    private func initTitleLabel() {
        let w = frame.width - 20 * 2
        let y = createdAtLabel.frame.height + createdAtLabel.frame.origin.y
        titleLabel.frame = CGRect(x: 20, y: y, width: w, height: 80)
    }

    private func initFavoriteImageView() {
        let y = titleLabel.frame.height + titleLabel.frame.origin.y
        favoriteImageView.frame = CGRect(x: 20, y: y, width: 30, height: 30)
    }

    private func initFavoriteLabel() {
        let x = favoriteImageView.frame.width + favoriteImageView.frame.origin.x
        let y = titleLabel.frame.height + titleLabel.frame.origin.y
        favoriteLabel.frame = CGRect(x: x, y: y, width: titleLabel.frame.width, height: titleLabel.frame.height)
    }

}
