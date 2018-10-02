//
//  ViewsPool.swift
//  FlatPageControl
//
//  Created by Александр Чаусов on 02.10.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

import UIKit

/// Struct for pool of some views
struct ViewsPool {
    
    // MARK: - Private Properties
    
    private var pool = [UIView]()
    
    // MARK: - Internal Methods
    
    /// Return first view, which don't have superview. If there is not such view, return nil
    func view() -> UIView? {
        let freeView = pool.first { (view) -> Bool in
            return view.superview == nil
        }
        return freeView
    }
    
    /// Allows you to push new item in pool
    mutating func push(_ item: UIView) {
        pool.append(item)
    }
    
}
