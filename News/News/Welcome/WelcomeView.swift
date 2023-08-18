//
//  WelcomeView.swift
//  News
//
//  Created by Yusuf Kaan USTA on 18.08.2023.
//

import Foundation
import UIKit

class WelcomeView: UIView {
    
    let welcomeBackgroundImage = UIImageView()
    let welcomeParagraph = UILabel()
    let button = UIButton()
    
    private var originalButtonTransform: CGAffineTransform = .identity
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
}

extension WelcomeView {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false

        if let customFont = UIFont(name: "Inter-Regular", size: 16) {
            welcomeParagraph.font = customFont
        } else {
            welcomeParagraph.font = UIFont.systemFont(ofSize: 16)
            
        }

        welcomeParagraph.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam."
        welcomeParagraph.textColor = .white
        welcomeParagraph.numberOfLines = 0
        welcomeParagraph.textAlignment = .center
        
        let letterSpacing: CGFloat = 2.5
        let attributedString = NSMutableAttributedString(string: welcomeParagraph.text ?? "")
        attributedString.addAttribute(.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length))
        welcomeParagraph.attributedText = attributedString

        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .white

        let buttonTitleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Inter-Medium", size: 14) ?? UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.black
        ]

        let attributedTitle = NSAttributedString(string: "Continue", attributes: buttonTitleAttributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(animateButton), for: .touchUpInside)
    }

    
    func layout() {
        addSubview(welcomeBackgroundImage)
        addSubview(welcomeParagraph)
        addSubview(button)
        
        welcomeBackgroundImage.translatesAutoresizingMaskIntoConstraints = false
        welcomeParagraph.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            welcomeBackgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            welcomeBackgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            welcomeBackgroundImage.topAnchor.constraint(equalTo: topAnchor),
            welcomeBackgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        welcomeBackgroundImage.image = UIImage(named: "WelcomeBackground")
        
        NSLayoutConstraint.activate([
            welcomeParagraph.centerXAnchor.constraint(equalTo: centerXAnchor),
            welcomeParagraph.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -48),
            welcomeParagraph.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            welcomeParagraph.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 72),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -72),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -72),
            button.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    @objc func animateButton() {
        UIView.animate(withDuration: 0.1, animations: {
            self.button.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.button.transform = CGAffineTransform.identity
            }
        }
        print("Tapped")
    }
}


