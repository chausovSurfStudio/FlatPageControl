//
//  FlatPageControlLogic.swift
//  FlatPageControl
//
//  Created by Александр Чаусов on 06.10.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

extension FlatPageControl {

    enum ScrollDirection: Int {
        case none
        case next
        case previous
    }

    // MARK: - Constants

    private struct Constants {
        static let animationDuration: TimeInterval = 0.2
        static let pageIndicatorWidth: CGFloat = 10
    }

}

// MARK: - Setup and layout logic

extension FlatPageControl {

    func setupControl() {
        let view = Bundle(for: type(of: self)).loadNibNamed(self.nameOfClass, owner: self, options: nil)?.first as? UIView
        if let v = view {
            addSubview(v)
            v.frame = self.bounds
        }
    }

    /// Method remove all indicators and redraw them
    func layoutPageIndicators() {
        let width: CGFloat = CGFloat(countOfVisibleIndicators()) * Constants.pageIndicatorWidth
        let height = self.bounds.height

        containerView.subviews.forEach({ $0.removeFromSuperview() })
        currentPageIndicators.removeAll()

        containerView.frame = CGRect(x: (self.bounds.width - width) / 2,
                                     y: 0,
                                     width: width,
                                     height: height)
        for i in 0..<countOfVisibleIndicators() {
            let indicator = newPageIndicator(with: CGRect(x: CGFloat(Constants.pageIndicatorWidth * CGFloat(i)),
                                                          y: 0,
                                                          width: Constants.pageIndicatorWidth,
                                                          height: height))
            containerView.addSubview(indicator)
            currentPageIndicators.append(indicator)
        }

        containerView.isHidden = numberOfPages == 1 && hidesForSinglePage
    }

    /// Method refresh and redraw page indicators (with shift animation if needed)
    func refreshCurrentPageIndicator(oldCurrentPage: Int) {
        let direction = scrollDirection()

        switch direction {
        case .next, .previous:
            removeAndHideIndicator(towards: direction)
            addIndicator(towards: direction)
            offset = direction == .next ? offset + 1 : offset - 1
            scrollIndicators(towards: direction)
            updatePageIndicatorsColor(animated: true)
        case .none:
            if numberOfPages > maxPagesNumber {
                if currentPage == 0 {
                    // current page is first page
                    offset = 0
                    updatePageIndicatorsColor(animated: true)
                } else if currentPage == (numberOfPages - 1) {
                    // current page is last page
                    offset = numberOfPages - maxPagesNumber
                    updatePageIndicatorsColor(animated: true)
                } else {
                    // case, when we shouldn't scroll our indicators, redraw only two indicators with animation
                    redrawPageIndicator(atIndex: oldCurrentPage - offset, color: colorForIndicator(at: oldCurrentPage), animated: true)
                    redrawPageIndicator(atIndex: currentPage - offset, color: colorForIndicator(at: currentPage), animated: true)
                }
            } else {
                // case, when number of pages less then max count, redraw only two indicators with animation
                redrawPageIndicator(atIndex: oldCurrentPage - offset, color: colorForIndicator(at: oldCurrentPage), animated: true)
                redrawPageIndicator(atIndex: currentPage - offset, color: colorForIndicator(at: currentPage), animated: true)
            }
        }
    }

    /// Method only refresh current indicators offset value depending on the currentPage value
    func refreshOffset() {
        if currentPage == 0 {
            offset = 0
        } else if offset + countOfVisibleIndicators() - 1 > currentPage && offset < currentPage {
            // nothing to do, the current page is in the visible range
        } else {
            let maxOffset = max(0, numberOfPages - maxPagesNumber)
            let leftOffsetFromCurrentPage: Int = maxPagesNumber - 2
            let maxAllowedOffsetForCurrentpage = max(0, currentPage - leftOffsetFromCurrentPage)
            offset = min(maxOffset, maxAllowedOffsetForCurrentpage)
        }
    }

}

// MARK: - Colors support methods

extension FlatPageControl {

    /// Method update colors for all indicators
    func updatePageIndicatorsColor(animated: Bool = false) {
        for index in 0..<currentPageIndicators.count {
            redrawPageIndicator(atIndex: index, color: colorForIndicator(at: index + offset), animated: animated)
        }
    }

    /// Method allows you update color for indicator at specific index in currentPageIndicators array
    func redrawPageIndicator(atIndex index: Int, color: UIColor, animated: Bool) {
        if index >= self.currentPageIndicators.count || index < 0 {
            return
        }
        let indicator = self.currentPageIndicators[index]
        if animated {
            UIView.animate(withDuration: Constants.animationDuration) {
                indicator.changeIndicatorColor(color)
            }
        } else {
            indicator.changeIndicatorColor(color)
        }
    }

    /// Method return color for indicator at specific index
    func colorForIndicator(at index: Int) -> UIColor {
        if index == currentPage {
            return currentPageIndicatorTintColor
        } else if isLeftExtraPage(index) || isRightExtraPage(index) {
            return extraPageIndicatorTintColor
        } else {
            return pageIndicatorTintColor
        }
    }

}

// MARK: - Private methods

extension FlatPageControl {

    /// Return you direction in which it is necessary to move the current indicators
    func scrollDirection() -> ScrollDirection {
        guard numberOfPages > maxPagesNumber else {
            return .none
        }
        if isRightExtraPage(currentPage) {
            return .next
        } else if isLeftExtraPage(currentPage) {
            return .previous
        }
        return .none
    }

    /// Remove last or first indicator from indicators array, shift and hide it with animation depending on the direction value
    func removeAndHideIndicator(towards direction: ScrollDirection) {
        guard direction == .next || direction == .previous else {
            return
        }
        let pageIndicator = direction == .next ? currentPageIndicators.first : currentPageIndicators.last
        let shiftValue = direction == .next ? -Constants.pageIndicatorWidth : Constants.pageIndicatorWidth
        guard let indicator = pageIndicator else {
            return
        }

        let indicatorOrigin = indicator.frame.origin
        if let index = currentPageIndicators.index(of: indicator) {
            currentPageIndicators.remove(at: index)
        }
        UIView.animate(withDuration: Constants.animationDuration, animations: {
            indicator.frame.origin = CGPoint(x: indicatorOrigin.x + shiftValue, y: indicatorOrigin.y)
            indicator.changeIndicatorColor(UIColor.white.withAlphaComponent(0.0))
        }) { (_) in
            indicator.removeFromSuperview()
        }
    }

    /// Method add page indicator in indicators array and on the view depending on the direction value
    func addIndicator(towards direction: ScrollDirection) {
        guard direction == .next || direction == .previous else {
            return
        }
        let xCoordinate = direction == .next ? containerView.bounds.size.width : -Constants.pageIndicatorWidth
        let height = self.bounds.height
        let indicator = newPageIndicator(with: CGRect(x: xCoordinate,
                                                      y: 0,
                                                      width: Constants.pageIndicatorWidth,
                                                      height: height))
        indicator.changeIndicatorColor(pageIndicatorTintColor.withAlphaComponent(0.0))
        containerView.addSubview(indicator)
        if direction == .next {
            currentPageIndicators.append(indicator)
        } else {
            currentPageIndicators.insert(indicator, at: 0)
        }
    }

    /// Method allows you to shift all indicators at passed direction animated
    func scrollIndicators(towards direction: ScrollDirection) {
        guard direction == .next || direction == .previous else {
            return
        }
        let shiftValue = direction == .next ? -Constants.pageIndicatorWidth : Constants.pageIndicatorWidth
        for indicator in currentPageIndicators {
            let origin = indicator.frame.origin
            UIView.animate(withDuration: Constants.animationDuration) {
                indicator.frame.origin = CGPoint(x: origin.x + shiftValue, y: origin.y)
            }
        }
    }

    /// Return you new page indicator with passed frame
    func newPageIndicator(with frame: CGRect) -> FlatPageIndicator {
        guard let indicator = viewsPool.view() as? FlatPageIndicator else {
            let indicator = FlatPageIndicator(frame: frame, tintColor: pageIndicatorTintColor)
            viewsPool.push(indicator)
            return indicator
        }
        indicator.frame = frame
        return indicator
    }

    func countOfVisibleIndicators() -> Int {
        return min(numberOfPages, maxPagesNumber)
    }

    func isLeftExtraPage(_ page: Int) -> Bool {
        return page == offset && offset > 0
    }

    func isRightExtraPage(_ page: Int) -> Bool {
        return page == offset + currentPageIndicators.count - 1 && page < numberOfPages - 1
    }

}
