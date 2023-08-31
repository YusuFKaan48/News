//
//  HomeViewController.swift
//  News
//
//  Created by Yusuf Kaan USTA on 19.08.2023.
//

import UIKit
import SafariServices

class HomeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate, UIScrollViewDelegate {

    let homeText = UILabel()
    let tableView = UITableView()
    let cellReuseIdentifier = "CellReuseIdentifier"
    var articles: [Article] = []
    let activityIndicatorView = UIActivityIndicatorView(style: .large)
    let refreshControl = UIRefreshControl()
    let UpListhStack = UIStackView()
    let UpListSecondhStack = UIStackView()
    let newsMainTitle = UILabel()
    let newsFromButton = UIButton()
    let newsFilterButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        setupTableView()
        fetchArticles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func style() {
        view.backgroundColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1.0)

        if let customFont = UIFont(name: "Inter-Bold", size: 16) {
            homeText.font = customFont
        } else {
            homeText.font = UIFont.systemFont(ofSize: 16)
        }

        homeText.text = "Home"
        homeText.textColor = .white
        homeText.textAlignment = .center
        
        UpListhStack.translatesAutoresizingMaskIntoConstraints = false

        UpListhStack.axis = .horizontal
        UpListhStack.spacing = 188
        
        UpListSecondhStack.axis = .horizontal
        UpListSecondhStack.spacing = 6
        
        if let customFont = UIFont(name: "Inter-Bold", size: 24) {
            newsMainTitle.font = customFont
        } else {
            newsMainTitle.font = UIFont.systemFont(ofSize: 24)
        }
        
        newsMainTitle.text = "News"
        newsMainTitle.textColor = .white
        newsMainTitle.textAlignment = .center
    

        newsFromButton.setTitle("-From this country", for: .normal)
        newsFromButton.setTitleColor(.white, for: .normal)
        newsFromButton.backgroundColor = .init(red: 47/255, green: 47/255, blue: 47/255, alpha: 1.0)

        let newsFromAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Inter-Bold", size: 12) ?? UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor(red: 213/255, green: 213/255, blue: 213/255, alpha: 1.0)
        ]

        let newsFromAttributedTitle = NSAttributedString(string: "-From this country", attributes: newsFromAttributes)
        newsFromButton.setAttributedTitle(newsFromAttributedTitle, for: .normal)
        newsFromButton.layer.cornerRadius = 4
        newsFromButton.addTarget(self, action: #selector(animateButton), for: .touchUpInside)
        

       
        let filterIcon = UIImage(named: "filter-list")
        newsFilterButton.setImage(filterIcon, for: .normal)

        newsFilterButton.setTitle("", for: .normal)
        newsFilterButton.setTitleColor(.white, for: .normal)
        newsFilterButton.backgroundColor = .init(red: 47/255, green: 47/255, blue: 47/255, alpha: 1.0)

        newsFilterButton.layer.cornerRadius = 4
        newsFilterButton.addTarget(self, action: #selector(animateButton2), for: .touchUpInside)
    }

    private func layout() {
        view.addSubview(homeText)
        view.addSubview(UpListhStack)
        

        homeText.translatesAutoresizingMaskIntoConstraints = false
       

        NSLayoutConstraint.activate([
            homeText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            homeText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
          
        UpListhStack.addArrangedSubview(UpListSecondhStack)
        UpListhStack.addArrangedSubview(newsFilterButton)
        UpListSecondhStack.addArrangedSubview(newsMainTitle)
        UpListSecondhStack.addArrangedSubview(newsFromButton)
        
        UpListhStack.translatesAutoresizingMaskIntoConstraints = false
        
        UpListhStack.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        
           let minWidthConstraint = newsFilterButton.widthAnchor.constraint(equalToConstant: 24)
           minWidthConstraint.priority = .required
           minWidthConstraint.isActive = true
           
           let minHeightConstraint = newsFilterButton.heightAnchor.constraint(equalToConstant: 24)
           minHeightConstraint.priority = .required
           minHeightConstraint.isActive = true
        
        
        
        NSLayoutConstraint.activate([
            UpListhStack.topAnchor.constraint(equalTo: homeText.bottomAnchor, constant: 16),
            UpListhStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            UpListhStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
    }
    
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        view.addSubview(activityIndicatorView)
        
        NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: UpListhStack.bottomAnchor, constant: 16),
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
    
    @objc func animateButton() {
        UIView.animate(withDuration: 0.1, animations: {
            self.newsFromButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.newsFromButton.transform = CGAffineTransform.identity
            }
            self.showCountrySelectionMenu() // Ülke seçim menüsünü göster
        }
        print("Tapped a news from button")
    }

    func showCountrySelectionMenu() {
        let alertController = UIAlertController(title: "Select Country", message: nil, preferredStyle: .actionSheet)
        
        let countries = ["us", "ca", "fr", "de", "jp", "cn", "tr"]
        
        for country in countries {
            let action = UIAlertAction(title: country.uppercased(), style: .default) { [weak self] _ in
                self?.fetchArticlesByCountry(country: country)
            }
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

    func fetchArticlesByCountry(country: String) {
        ApiCall.shared.getTopStoriesByCountry(country: country) { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.refreshControl.endRefreshing()
                }
            case .failure(let error):
                print("Error fetching articles:", error)
                self?.refreshControl.endRefreshing()
            }
        }
    }

    
    @objc func animateButton2() {
        UIView.animate(withDuration: 0.1, animations: {
            self.newsFilterButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.newsFilterButton.transform = CGAffineTransform.identity
            }
            self.showCategorySelectionMenu()
        }
        print("Tapped a filter icon")
    }

    func showCategorySelectionMenu() {
        let alertController = UIAlertController(title: "Select Category", message: nil, preferredStyle: .actionSheet)
        
        let categories = ["business", "entertainment", "general", "health", "science", "sports", "technology"]
        
        for category in categories {
            let action = UIAlertAction(title: category.capitalized, style: .default) { [weak self] _ in
                self?.fetchArticlesByCategory(category: category)
            }
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

    func fetchArticlesByCategory(category: String) {
        ApiCall.shared.getTopStoriesByCategory(category: category) { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.refreshControl.endRefreshing()
                }
            case .failure(let error):
                print("Error fetching articles:", error)
                self?.refreshControl.endRefreshing()
            }
        }
    }

    
    func set(icon: UIImage?, title: String) {
           newsFilterButton.setImage(icon, for: .normal)
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
