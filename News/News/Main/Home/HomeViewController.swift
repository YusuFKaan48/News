//
//  HomeViewController.swift
//  News
//
//  Created by Yusuf Kaan USTA on 19.08.2023.
//

import UIKit

class HomeViewController: UIViewController {

    let listViewController = ListViewController()
    let homeText = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
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
    }

    private func layout() {
        view.addSubview(homeText)
        view.addSubview(listViewController.view)

        homeText.translatesAutoresizingMaskIntoConstraints = false
        listViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            homeText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            homeText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])

        NSLayoutConstraint.activate([
            listViewController.view.topAnchor.constraint(equalTo: homeText.bottomAnchor, constant: 16),
            listViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            listViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            listViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
