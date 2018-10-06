//
//  FlatPageControl.swift
//  FlatPageControl
//
//  Created by Александр Чаусов on 02.10.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

import UIKit

/// Custom page control with a limited number of visible indicators
public class FlatPageControl: UIControl {

    // MARK: - ColorConstants

    private struct ColorConstants {
        static let defaultPageIndicatorTintColor = UIColor.white.withAlphaComponent(0.2)
        static let defaultCurrentPageIndicatorTintColor = UIColor.white
        static let defaultExtraPageIndicatorTintColor = UIColor.white.withAlphaComponent(0.1)
    }

    // MARK: - IBOutlets
    
    @IBOutlet var containerView: UIView!
    
    // MARK: - Public Properties
    
    public var view: UIView! {
        return subviews.first
    }
    public var maxPagesNumber: Int = 16
    public var numberOfPages: Int = 1 {
        didSet {
            layoutSubviews()
        }
    }
    public var hidesForSinglePage: Bool = true {
        didSet {
            layoutSubviews()
        }
    }
    public var pageIndicatorTintColor: UIColor = ColorConstants.defaultPageIndicatorTintColor {
        didSet {
            updatePageIndicatorsColor()
        }
    }
    public var currentPageIndicatorTintColor: UIColor = ColorConstants.defaultCurrentPageIndicatorTintColor {
        didSet {
            updatePageIndicatorsColor()
        }
    }
    public var extraPageIndicatorTintColor: UIColor = ColorConstants.defaultExtraPageIndicatorTintColor {
        didSet {
            updatePageIndicatorsColor()
        }
    }

    // MARK: - Internal Properties

    var viewsPool: ViewsPool = ViewsPool()
    var currentPageIndicators: [FlatPageIndicator] = []
    var offset: Int = 0
    var currentPage: Int = 0

    // MARK: - UIControl
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupControl()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupControl()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layoutPageIndicators()
        updatePageIndicatorsColor()
    }
    
    // MARK: - Public Methods
    
    /**
     Method allows you to set the current page index and pass "animated" flag
     - Note: it is recommended to set the current page with the animation only if the user changes the number of the visible page manually, without animation in other case (for example, on view setup)
     */
    public func setCurrentPage(_ currentPage: Int, animated: Bool) {
        guard currentPage < numberOfPages else {
            return
        }
        if self.currentPage != currentPage {
            let oldCurrentPage = self.currentPage
            self.currentPage = currentPage
            if animated && abs(currentPage - oldCurrentPage) == 1 {
                refreshCurrentPageIndicator(oldCurrentPage: oldCurrentPage)
            } else {
                refreshOffset()
                layoutSubviews()
            }
        }
    }
    
}
