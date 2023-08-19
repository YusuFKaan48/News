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
    }

    private func hideNavigationBarLine(_ navigationBar: UINavigationBar) {
        let img = UIImage()
        navigationBar.shadowImage = img
        navigationBar.setBackgroundImage(img, for: .default)
        navigationBar.isTranslucent = false
    }

    private func setupTabBar() {
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.6)
        tabBar.backgroundColor = .init(red: 20/255, green: 20/255, blue: 20/255, alpha: 1.0)
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
            .foregroundColor: UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.6)
        ]

        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes(unselectedAttributes, for: .normal)
        
        let iconSize = CGSize(width: 24, height: 24)
        for item in tabBar.items ?? [] {
            item.image = item.image?.resize(targetSize: iconSize)
        }
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
