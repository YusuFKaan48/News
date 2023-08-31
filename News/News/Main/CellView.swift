//
//  CellView.swift
//  News
//
//  Created by Yusuf Kaan USTA on 20.08.2023.
//

import UIKit

class CellView: UITableViewCell {
    let hStack = UIStackView()
    let newsImage = UIImageView()
    let vStack = UIStackView()
    let newsTitle = UILabel()
    let newsParagraph = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        styleUI()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func styleUI() {
        backgroundColor = UIColor(red: 29/255, green: 29/255, blue: 29/255, alpha: 1.0)
        
        contentView.addSubview(hStack)
        hStack.axis = .horizontal
        hStack.spacing = 12
        
        hStack.addArrangedSubview(newsImage)
        hStack.addArrangedSubview(vStack)

        vStack.axis = .vertical
        vStack.spacing = 4 
        
        vStack.addArrangedSubview(newsTitle)
        vStack.addArrangedSubview(newsParagraph)

        newsTitle.font = UIFont(name: "Inter-Medium", size: 14)
        newsTitle.textColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
        newsTitle.numberOfLines = 2

        newsParagraph.font = UIFont(name: "Inter-Medium", size: 12)
        newsParagraph.textColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)
        newsParagraph.numberOfLines = 2
        
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        newsImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        newsImage.layer.cornerRadius = 8
        newsImage.clipsToBounds = true
    }

    func layout() {
        hStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            hStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            hStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            hStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            newsImage.heightAnchor.constraint(equalTo: vStack.heightAnchor) 
        ])
    }

    func configure(with article: Article) {
        newsTitle.text = article.title
        newsParagraph.text = article.description

        if let imageURLString = article.urlToImage, let imageURL = URL(string: imageURLString) {
            URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
                if let error = error {
                    print("Error loading image:", error)
                } else if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.newsImage.image = image
                    }
                }
            }.resume()
        } else {
            self.newsImage.image = UIImage(named: "placeholder")
        }
    }
}
