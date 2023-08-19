//
//  WelcomeViewController.swift
//  News
//
//  Created by Yusuf Kaan USTA on 18.08.2023.
//

import UIKit

class WelcomeViewController: UIViewController {

    let welcomeView = WelcomeView()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension WelcomeViewController {
    private func style() {
        welcomeView.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .white

        let buttonTitleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Inter-Bold", size: 14) ?? UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.black
        ]

        let attributedTitle = NSAttributedString(string: "Continue", attributes: buttonTitleAttributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(animateButton), for: .touchUpInside)
    }
    private func layout() {
        view.addSubview(welcomeView)
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            welcomeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            welcomeView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: welcomeView.trailingAnchor, multiplier: 0),
            welcomeView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.bottomAnchor, multiplier: 0)
        ])
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 72),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -72),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -72),
            button.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
    @objc func animateButton() {
        UIView.animate(withDuration: 0.1, animations: {
            self.button.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.button.transform = CGAffineTransform.identity
                (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = OnboardingContainerViewController()
            }
        }
        print("Tapped in welcome screen")
    }

}
