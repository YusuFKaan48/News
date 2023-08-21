//
//  SearchViewController.swift
//  News
//
//  Created by Yusuf Kaan USTA on 19.08.2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    let welcomeView = WelcomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension SearchViewController {
    private func style() {
        welcomeView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout() {
        
    }
}

