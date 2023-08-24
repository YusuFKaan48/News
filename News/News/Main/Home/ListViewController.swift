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
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 96
        tableView.layer.cornerRadius = 4
        tableView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.04)

        tableView.register(CellView.self, forCellReuseIdentifier: cellReuseIdentifier)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! CellView
        
        let article = articles[indexPath.row]
        cell.configure(with: article)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
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

    func fetchArticles() {
        ApiCall.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching articles:", error)
            }
        }
    }
}
