//
//  CellView.swift
//  News
//
//  Created by Yusuf Kaan USTA on 20.08.2023.
//

import Foundation
import UIKit

class CellView: UIView {
    
    let hStack = UIStackView()
    let vStack = UIStackView()
    let newsImage = UIImageView()
    let newsTitle = UILabel()
    let newsParagraph = UILabel()
    
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

extension CellView {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        hStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        hStack.axis = .horizontal
        hStack.spacing = 12
        
        vStack.axis = .vertical
        vStack.spacing = 6
        
        if let customFont = UIFont(name: "Inter-Medium", size: 16) {
            newsTitle.font = customFont
        } else {
            newsTitle.font = UIFont.systemFont(ofSize: 16)
            
        }
        
        newsTitle.text = "NewsTitle"
        newsTitle.textColor = .init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)

        
        if let customFont = UIFont(name: "Inter-Medium", size: 16) {
            newsParagraph.font = customFont
        } else {
            newsParagraph.font = UIFont.systemFont(ofSize: 16)
            
        }
        
        newsParagraph.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore"
        newsParagraph.textColor = .init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.6)
    }
    
    func layout() {
      addSubview(hStack)
        
        hStack.addArrangedSubview(newsImage)
        hStack.addArrangedSubview(vStack)
        vStack.addArrangedSubview(newsTitle)
        vStack.addArrangedSubview(newsParagraph)
        
        newsImage.image = UIImage(named: "search")
    }
}
