//
//  ListView.swift
//  News
//
//  Created by Yusuf Kaan USTA on 20.08.2023.
//

import UIKit
import SafariServices

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate {

    let tableView = UITableView()
    let cellReuseIdentifier = "CellReuseIdentifier"
    var articles: [Article] = []
    let activityIndicatorView = UIActivityIndicatorView(style: .large)
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchArticles()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        let listUpView = ListUpView()
        tableView.tableHeaderView = listUpView

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 106
        tableView.layer.cornerRadius = 8
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableView.layer.masksToBounds = true
        tableView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.04)
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.separatorColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2)

        tableView.register(CellView.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.selectionFollowsFocus = false

        view.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicatorView.startAnimating()

        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! CellView

        let article = articles[indexPath.row]
        cell.configure(with: article)

        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor(white: 1.0, alpha: 0.1)
        cell.selectedBackgroundView = selectedBackgroundView

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]

        guard let urlString = article.url, let url = URL(string: urlString) else {
            print("Empty or invalid URL")
            return
        }

        if let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let searchURL = URL(string: "\(encodedUrlString)") {
            if UIApplication.shared.canOpenURL(searchURL) {
                UIApplication.shared.open(searchURL, options: [:], completionHandler: nil)
            } else {
                print("Cannot open URL: \(searchURL)")
            }
        }
    }

    @objc func refreshTable() {
        fetchArticles()
    }

    func fetchArticles() {
        ApiCall.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.activityIndicatorView.stopAnimating()
                    self?.activityIndicatorView.removeFromSuperview()
                    self?.refreshControl.endRefreshing()
                }
            case .failure(let error):
                print("Error fetching articles:", error)
                self?.refreshControl.endRefreshing()
            }
        }
    }
}
