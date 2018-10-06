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

    // MARK: - Constants

    private struct Constants {
        static let numberOfPages = 25
    }

    // MARK: - IBOutlets

    @IBOutlet private weak var pageControl: FlatPageControl!

    // MARK: - Private Properties

    private var currentPage: Int = 0

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = Constants.numberOfPages
        pageControl.setCurrentPage(currentPage, animated: false)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

// MARK: - Actions

private extension ViewController {

    @IBAction func tapOnPrevButton(_ sender: UIButton) {
        currentPage -= 1
        if currentPage < 0 {
            currentPage = Constants.numberOfPages - 1
        }
        pageControl.setCurrentPage(currentPage, animated: true)
    }

    @IBAction func tapOnNextButton(_ sender: UIButton) {
        currentPage += 1
        if currentPage >= Constants.numberOfPages {
            currentPage = 0
        }
        pageControl.setCurrentPage(currentPage, animated: true)
    }

}
