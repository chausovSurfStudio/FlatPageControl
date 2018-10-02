//
//  FlatPageIndicator.swift
//  FlatPageControl
//
//  Created by Александр Чаусов on 02.10.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

import UIKit

/// Class for custom page indicator in FlatPageControl
final class FlatPageIndicator: UIView {
    
    // MARK: - Constans
    
    private struct Constants {
        static let indicatorWidth: CGFloat = 5
        static let indicatorHeight: CGFloat = 5
    }
    
    // MARK: - Private Properties
    
    private var indicatorTintColor: UIColor?
    
    // MARK: - UIView
    
    init(frame: CGRect, tintColor: UIColor) {
        super.init(frame: frame)
        self.indicatorTintColor = tintColor
        self.initializeView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initializeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Methods
    
    func changeIndicatorColor(_ color: UIColor) {
        indicatorTintColor = color
        for indicator in subviews {
            indicator.backgroundColor = color
        }
    }
}

// MARK: - Private Methods

private extension FlatPageIndicator {
    
    func initializeView() {
        self.backgroundColor = UIColor.clear
        
        let indicator = UIView(frame: CGRect(x: (self.bounds.width - Constants.indicatorWidth) / 2,
                                             y: (self.bounds.height - Constants.indicatorHeight) / 2,
                                             width: Constants.indicatorWidth,
                                             height: Constants.indicatorHeight))
        indicator.backgroundColor = indicatorTintColor
        indicator.layer.cornerRadius = Constants.indicatorHeight / 2
        indicator.layer.masksToBounds = true
        self.addSubview(indicator)
    }
    
}

