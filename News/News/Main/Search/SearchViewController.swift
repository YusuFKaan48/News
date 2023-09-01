//
//  SearchViewController.swift
//  News
//
//  Created by Yusuf Kaan USTA on 19.08.2023.
//

import UIKit
import SafariServices

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate, UIScrollViewDelegate   {
    
    let searchBar = UISearchBar()
    private let searchVC = UISearchController(searchResultsController: nil)
    let tableView = UITableView()
    let cellReuseIdentifier = "CellReuseIdentifier"
    var articles: [Article] = []
    let activityIndicatorView = UIActivityIndicatorView(style: .large)
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        setupSearchBar()
        setupTableView()
        fetchArticles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func style() {
        view.backgroundColor = UIColor(red: 29/255, green: 29/255, blue: 29/255, alpha: 1.0)
    }
    
    // Seach Bar
    
    private func setupSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
        searchVC.searchBar.setShowsCancelButton(false, animated: false)
        searchVC.hidesNavigationBarDuringPresentation = false
        }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }
        
        ApiCall.shared.search(with: searchText) { [weak self] result in
            switch result {
            case .success(let articles):
                let validArticles = articles.filter { $0.url != nil && URL(string: $0.url!) != nil }
                self?.articles = validArticles
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error searching the articles:", error)
            }
        }
    }
    
    // Table View
    
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        view.addSubview(searchBar)
        view.addSubview(activityIndicatorView)
            
        NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 106
        tableView.layer.cornerRadius = 8
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableView.layer.masksToBounds = true
        tableView.backgroundColor = UIColor(red: 29/255, green: 29/255, blue: 29/255, alpha: 1.0)
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.separatorColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1.0)
        
        tableView.register(CellView.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.selectionFollowsFocus = false
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)

        ])
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
            tableView.deselectRow(at: indexPath, animated: false)
            let article = articles[indexPath.row]
            
            guard let urlString = article.url, let url = URL(string: urlString) else {
                print("Empty or invalid URL")
                return
            }
            
            if UIApplication.shared.canOpenURL(url) {
                let vc = SFSafariViewController(url: url)
                vc.delegate = self
                present(vc, animated: true, completion: nil)
            } else {
                print("Cannot open URL: \(url)")
            }
        }
    
    @objc func refreshTable() {
        fetchArticles()
    }
    
    func fetchArticles() {
            ApiCall.shared.getTopStories { [weak self] result in
                switch result {
                case .success(let articles):
                    let validArticles = articles.filter { $0.url != nil && URL(string: $0.url!) != nil }
                    self?.articles = validArticles
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
