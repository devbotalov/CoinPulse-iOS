//
//  BaseViewController.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 06.10.2024.
//

import UIKit

class BaseViewController<Router>: UIViewController {
    
    var router: Router?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    func setupViewController() {
        setupNavigationBar()
        setupSubviews()
        setupConstraints()
    }
    
    func setupNavigationBar() {}
    
    func setupSubviews() {}
    
    func setupConstraints() {}
}
