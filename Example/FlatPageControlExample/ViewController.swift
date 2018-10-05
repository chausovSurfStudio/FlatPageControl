//
//  ViewController.swift
//  FlatPageControlExample
//
//  Created by Александр Чаусов on 02.10.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

import UIKit
import FlatPageControl

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var pageControl: FlatPageControl!
    
    // MARK: - Private Properties
    
    private var currentPage: Int = 0
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = 25
        pageControl.setCurrentPage(currentPage, animated: false)
    }

}

// MARK: - Actions

private extension ViewController {
    
    @IBAction func tapOnPrevButton(_ sender: UIButton) {
        currentPage -= 1
        pageControl.setCurrentPage(currentPage, animated: true)
    }
    
    @IBAction func tapOnNextButton(_ sender: UIButton) {
        currentPage += 1
        pageControl.setCurrentPage(currentPage, animated: true)
    }
    
}
