//
//  HomeViewController.swift
//  News
//
//  Created by Yusuf Kaan USTA on 19.08.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    let listUpView = ListUpView()
    let listView = ListView()
    let cellView = CellView()
    
    
    
    let homeText = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension HomeViewController {
    private func style() {
        
        view.backgroundColor = .init(red: 20/255, green: 20/255, blue: 20/255, alpha: 1.0)
        
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
        view.addSubview(listView)
            
        homeText.translatesAutoresizingMaskIntoConstraints = false
        listUpView.translatesAutoresizingMaskIntoConstraints = false
            
        NSLayoutConstraint.activate([
            homeText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            homeText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            listUpView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           listUpView.topAnchor.constraint(equalTo: homeText.bottomAnchor, constant: 32),
            listUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            listUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
       ])
    }
}
