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

    private lazy var searchBar: UISearchBar = {
        let searchBar: UISearchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = NSLocalizedString("home.seach_filed_placeholder", comment: "")
        searchBar.tintColor = UIColor.gray
        searchBar.keyboardType = UIKeyboardType.default
        return searchBar
    }()

    private lazy var tableView = {
        let tableView = UITableView()
        tableView.register(QiitaArticleCell.self, forCellReuseIdentifier: QiitaArticleCell.id)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()

    lazy var indicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.color = .green40
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Combine

    private let viewModel = HomeViewModel()
    private var cancellables: Set<AnyCancellable> = []

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
        view.addSubview(indicatorView)

        view.backgroundColor = .gray10

        setConstraint()
        addObserver()

        if let navigationBarFrame = navigationController?.navigationBar.bounds {
            searchBar.frame = navigationBarFrame
            navigationItem.titleView = searchBar
            navigationItem.titleView?.frame = searchBar.frame
        }

        viewModel.loadQiitaArticles(isLoadMore: false)
    }

}

// MARK: - Constraint

private extension HomeViewController {

    func setConstraint() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        indicatorView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        indicatorView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        indicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        indicatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    }

}

// MARK: - Observer

private extension HomeViewController {

    func addObserver() {
        viewModel.$articles
            .sink(receiveValue: { articles in
                self.articles = articles
            }).store(in: &cancellables)

        viewModel.$isLoading
            .sink(receiveValue: { isLoading in
                if isLoading {
                    self.indicatorView.startAnimating()
                } else {
                    self.indicatorView.stopAnimating()
                }
            }).store(in: &cancellables)
    }
    
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let marginView = UIView()
        marginView.backgroundColor = .clear
        return marginView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QiitaArticleCell.id, for: indexPath)
        if let cell = cell as? QiitaArticleCell {
            cell.article = articles[indexPath.section]
        }
        cell.selectionStyle = .none
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.section]
        let url = NSURL(string: article.url)
        if UIApplication.shared.canOpenURL(url! as URL) {
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1 &&
            indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            viewModel.loadQiitaArticles(isLoadMore: true)
        }
    }

}

// MARK: - UISearchBarDelegate

extension HomeViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let word = searchBar.text {
            viewModel.loadQiitaArticles(query: word, isLoadMore: false)
        }
    }

}
