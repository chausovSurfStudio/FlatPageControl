//
//  NSObject.swift
//  FlatPageControl
//
//  Created by Александр Чаусов on 06.10.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

extension NSObject {

    @objc var nameOfClass: String {
        if let name = NSStringFromClass(type(of: self)).components(separatedBy: ".").last {
            return name
        }
        return ""
    }

}
