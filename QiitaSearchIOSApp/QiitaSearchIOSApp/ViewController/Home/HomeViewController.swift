//
//  HomeViewController.swift
//  QiitaSearchIOSApp
//
//  Created by 松浦裕久 on 2023/10/01.
//

import UIKit
import Combine

class HomeViewController: UIViewController {

    // MARK: - Subview

    private lazy var tableView = {
        let tableView = UITableView()
        tableView.register(QiitaArticleCell.self, forCellReuseIdentifier: QiitaArticleCell.id)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Combine

    private let viewModel = HomeViewModel()
    private var cancellable: AnyCancellable?

    // MARK: - Model
    private var articles: [QiitaArticleModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - UIViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        setConstraint()

        viewModel.searchQiitaArticles()
        addObserver()
    }

}

// MARK: - Private

private extension HomeViewController {

    func setConstraint() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func addObserver() {
        cancellable = viewModel.$articles
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    break
                }
            } receiveValue: { articles in
                self.articles = articles
            }
    }

}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QiitaArticleCell.id, for: indexPath)
        if let cell = cell as? QiitaArticleCell {
            cell.article = articles[indexPath.row]
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {}
