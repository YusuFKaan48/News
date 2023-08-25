//
//  HomeViewController.swift
//  News
//
//  Created by Yusuf Kaan USTA on 19.08.2023.
//

import UIKit

class HomeViewController: UIViewController {

    let listUpView = ListUpView()
    let listViewController = ListViewController()
    let homeText = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()

        loadNews()
    }

    private func loadNews() {
        ApiCall.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                DispatchQueue.main.async {
                    self?.listViewController.articles = articles
                    self?.listViewController.tableView.reloadData()
                }
            case .failure(let error):
                print("News fetch error: \(error)")
            }
        }
    }

    private func style() {
        view.backgroundColor = .black

        if let customFont = UIFont(name: "Inter-Bold", size: 16) {
            homeText.font = customFont
        } else {
            homeText.font = UIFont.systemFont(ofSize: 16)
        }

        homeText.text = "Home"
        homeText.textColor = .white
        homeText.textAlignment = .center
    }

    private func layout() {
        view.addSubview(homeText)
        view.addSubview(listUpView)
        view.addSubview(listViewController.view)

        homeText.translatesAutoresizingMaskIntoConstraints = false
        listUpView.translatesAutoresizingMaskIntoConstraints = false
        listViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            homeText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            homeText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])

        NSLayoutConstraint.activate([
            listUpView.topAnchor.constraint(equalTo: homeText.bottomAnchor, constant: 32),
            listUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            listUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])

        NSLayoutConstraint.activate([
            listViewController.view.topAnchor.constraint(equalTo: listUpView.bottomAnchor, constant: 16),
            listViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            listViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            listViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
    }
}
