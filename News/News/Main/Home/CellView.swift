//
//  CellView.swift
//  News
//
//  Created by Yusuf Kaan USTA on 20.08.2023.
//

import UIKit

class CellView: UITableViewCell {
    let hStack = UIStackView()
    let vStack = UIStackView()
    let newsImage = UIImageView()
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
        backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.04)
        
        contentView.addSubview(hStack)
        hStack.axis = .horizontal
        hStack.spacing = 12
        
        hStack.addArrangedSubview(newsImage)
        hStack.addArrangedSubview(vStack)

        vStack.axis = .vertical
        
        vStack.addArrangedSubview(newsTitle)
        vStack.addArrangedSubview(newsParagraph)

        newsTitle.font = UIFont(name: "Inter-Medium", size: 14)
        newsTitle.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
        newsTitle.numberOfLines = 2

        newsParagraph.font = UIFont(name: "Inter-Medium", size: 12)
        newsParagraph.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.6)
        newsParagraph.numberOfLines = 2
        
        newsTitle.setContentCompressionResistancePriority(.required, for: .vertical)
        newsParagraph.setContentCompressionResistancePriority(.required, for: .vertical)

     
        newsImage.layer.cornerRadius = 8
        newsImage.clipsToBounds = true
    }

    func layout() {
        hStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.translatesAutoresizingMaskIntoConstraints = false
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        newsTitle.translatesAutoresizingMaskIntoConstraints = false
        newsParagraph.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            
            hStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            hStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            hStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            hStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            vStack.topAnchor.constraint(equalTo: hStack.topAnchor),
            vStack.leadingAnchor.constraint(equalTo: newsImage.trailingAnchor, constant: 12),
            vStack.trailingAnchor.constraint(equalTo: hStack.trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: hStack.bottomAnchor),
            
        newsImage.widthAnchor.constraint(equalToConstant: 80),
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
