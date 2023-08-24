//
//  ListUpView.swift
//  News
//
//  Created by Yusuf Kaan USTA on 20.08.2023.
//

import Foundation
import UIKit

class ListUpView: UIView {
    
    let UpListhStack = UIStackView()
    let UpListSecondhStack = UIStackView()
    let newsMainTitle = UILabel()
    let newsFromButton = UIButton()
    let newsFilterButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 24)
    }
}

extension ListUpView {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        UpListhStack.translatesAutoresizingMaskIntoConstraints = false

        UpListhStack.axis = .horizontal
        UpListhStack.spacing = 137
        
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
    

        newsFromButton.setTitle("-From New York Times", for: .normal)
        newsFromButton.setTitleColor(.white, for: .normal)
        newsFromButton.backgroundColor = .init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.08)

        let newsFromAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Inter-Bold", size: 12) ?? UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
        ]

        let newsFromAttributedTitle = NSAttributedString(string: "-From New York Times", attributes: newsFromAttributes)
        newsFromButton.setAttributedTitle(newsFromAttributedTitle, for: .normal)
        newsFromButton.layer.cornerRadius = 4
        newsFromButton.addTarget(self, action: #selector(animateButton), for: .touchUpInside)
        

       
        let filterIcon = UIImage(named: "filter-list")
        newsFilterButton.setImage(filterIcon, for: .normal)

        newsFilterButton.setTitle("", for: .normal)
        newsFilterButton.setTitleColor(.white, for: .normal)
        newsFilterButton.backgroundColor = .init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.08)

        newsFilterButton.layer.cornerRadius = 4
        newsFilterButton.addTarget(self, action: #selector(animateButton2), for: .touchUpInside)
    }
    
    func layout() {
        addSubview(UpListhStack)
          
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
            UpListhStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            UpListhStack.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    
    @objc func animateButton() {
        UIView.animate(withDuration: 0.1, animations: {
            self.newsFromButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.newsFromButton.transform = CGAffineTransform.identity
            }
        }
        print("Tapped a news from button")
    }
    
    @objc func animateButton2() {
        UIView.animate(withDuration: 0.1, animations: {
            self.newsFilterButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.newsFilterButton.transform = CGAffineTransform.identity
            }
        }
        print("Tapped a filter icon")
    }
}

extension ListUpView {
    func setTabBarImage(icon: UIImage?, title: String) {
        newsFilterButton.setImage(icon, for: .normal)
    }
}

