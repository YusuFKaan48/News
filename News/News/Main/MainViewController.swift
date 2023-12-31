//
//  MainViewController.swift
//  News
//
//  Created by Yusuf Kaan USTA on 19.08.2023.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTabBar()
    }

    private func setupViews() {
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        
        let homeIcon = UIImage(named: "home-simple")
        let searchIcon = UIImage(named: "search")
        
        homeVC.setTabBarImage(icon: homeIcon, title: "Home")
        searchVC.setTabBarImage(icon: searchIcon, title: "Search")

        let homeyNC = UINavigationController(rootViewController: homeVC)
        let searchNC = UINavigationController(rootViewController: searchVC)

        homeyNC.navigationBar.barTintColor = .black
        hideNavigationBarLine(homeyNC.navigationBar)

        let tabBarList = [homeyNC, searchNC]

        viewControllers = tabBarList
        
        view.backgroundColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1.0)
    }

    private func hideNavigationBarLine(_ navigationBar: UINavigationBar) {
        let img = UIImage()
        navigationBar.shadowImage = img
        navigationBar.setBackgroundImage(img, for: .default)
        navigationBar.isTranslucent = false
    }

    private func setupTabBar() {
            tabBar.tintColor = .white
            tabBar.unselectedItemTintColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)
            tabBar.backgroundColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1.0)
            tabBar.isTranslucent = false

            guard let customFont = UIFont(name: "Inter-Bold", size: 13) else {
                fatalError("Özel font yüklenemedi.")
            }

            let attributes: [NSAttributedString.Key: Any] = [
                .font: customFont,
                .foregroundColor: UIColor.white
            ]

            let selectedAttributes: [NSAttributedString.Key: Any] = [
                .font: customFont,
                .foregroundColor: UIColor.white
            ]

            let unselectedAttributes: [NSAttributedString.Key: Any] = [
                .font: customFont,
                .foregroundColor: UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)
            ]

            UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
            UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)
            UITabBarItem.appearance().setTitleTextAttributes(unselectedAttributes, for: .normal)
            
            let iconSize = CGSize(width: 20, height: 20)
            for item in tabBar.items ?? [] {
                item.image = item.image?.resize(targetSize: iconSize)
            }
            
            let bottomLineView = UIView()
            bottomLineView.backgroundColor = UIColor.init(red: 74/255, green: 74/255, blue: 74/255, alpha: 1.0)
            bottomLineView.translatesAutoresizingMaskIntoConstraints = false
            tabBar.addSubview(bottomLineView)

            NSLayoutConstraint.activate([
                bottomLineView.topAnchor.constraint(equalTo: tabBar.topAnchor),
                bottomLineView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
                bottomLineView.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
                bottomLineView.heightAnchor.constraint(equalToConstant: 1)
            ])
            
            tabBar.bringSubviewToFront(bottomLineView)
        }
}

extension UIImage {
    func resize(targetSize: CGSize) -> UIImage {
        let size = self.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        let newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }

        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage ?? self
    }
}

extension UIViewController {
    func setTabBarImage(icon: UIImage?, title: String) {
        tabBarItem.image = icon
        tabBarItem.title = title
    }
}
