//
//  HomeViewController.swift
//  News
//
//  Created by Yusuf Kaan USTA on 19.08.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    let welcomeView = WelcomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension HomeViewController {
    private func style() {
        welcomeView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout() {
        
    }
}
