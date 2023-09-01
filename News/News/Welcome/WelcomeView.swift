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

        welcomeParagraph.text = "Experience a sleek and minimalistic interface for news reading."
        welcomeParagraph.textColor = .white
        welcomeParagraph.numberOfLines = 0
        welcomeParagraph.textAlignment = .center
        
        let letterSpacing: CGFloat = 2.5
        let attributedString = NSMutableAttributedString(string: welcomeParagraph.text ?? "")
        attributedString.addAttribute(.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length))
        welcomeParagraph.attributedText = attributedString

    }

    
    func layout() {
        addSubview(welcomeBackgroundImage)
        addSubview(welcomeParagraph)
        
        welcomeBackgroundImage.translatesAutoresizingMaskIntoConstraints = false
        welcomeParagraph.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            welcomeBackgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            welcomeBackgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            welcomeBackgroundImage.topAnchor.constraint(equalTo: topAnchor),
            welcomeBackgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        welcomeBackgroundImage.image = UIImage(named: "WelcomeBackground")
        
        NSLayoutConstraint.activate([
            welcomeParagraph.centerXAnchor.constraint(equalTo: centerXAnchor),
            welcomeParagraph.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -164),
            welcomeParagraph.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            welcomeParagraph.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
    }
}
