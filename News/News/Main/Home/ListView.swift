//
//  ListView.swift
//  News
//
//  Created by Yusuf Kaan USTA on 20.08.2023.
//

import Foundation
import UIKit

class ListView: UIView {
    let scrollView = UIScrollView()
    let cellView = CellView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func style(){
        backgroundColor = .init(red: 20/255, green: 20/255, blue: 20/255, alpha: 1.0)
    }

    func layout() {
        addSubview(scrollView)
        scrollView.addSubview(cellView)
        
        cellView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            cellView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
        ])
    }
}
