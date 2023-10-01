//
//  HomeViewController.swift
//  QiitaSearchIOSApp
//
//  Created by 松浦裕久 on 2023/10/01.
//

import UIKit

class HomeViewController: UIViewController {

    let viewModel = HomeViewModel()

    private lazy var qiitaArticleView = {
        return QiitaArticleView()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(qiitaArticleView)
        viewModel.searchQiitaArticles()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        qiitaArticleView.frame = CGRect(x: 20, y: 20, width: view.frame.width - 40, height: 80)
    }

}
