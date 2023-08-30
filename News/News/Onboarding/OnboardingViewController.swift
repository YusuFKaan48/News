//
//  OnboardingViewController.swift
//  News
//
//  Created by Yusuf Kaan USTA on 18.08.2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    let stackView = UIStackView()
    let onboardImageView = UIImageView()
    let titleLabel = UILabel()
    
    let onboardImageName: String
    let titleText: String
    
    init(onboardImageName: String, titleText: String) {
        self.onboardImageName = onboardImageName
        self.titleText = titleText
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented - not using storyboards")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension OnboardingViewController {
    func style() {
        view.backgroundColor = .systemBackground
        
        onboardImageView.translatesAutoresizingMaskIntoConstraints = false
        onboardImageView.image = UIImage(named: onboardImageName)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = titleText
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        if let customFont = UIFont(name: "Inter-Regular", size: 16) {
            titleLabel.font = customFont
        } else {
            titleLabel.font = UIFont.systemFont(ofSize: 16)
        }
        
        let letterSpacing: CGFloat = 2.5
        let attributedString = NSMutableAttributedString(string: titleLabel.text ?? "")
        attributedString.addAttribute(.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length))
        titleLabel.attributedText = attributedString
    }
    
    func layout() {
        view.addSubview(onboardImageView)
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            onboardImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onboardImageView.topAnchor.constraint(equalTo: view.topAnchor),
            onboardImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -128)
        ])
    }
}
