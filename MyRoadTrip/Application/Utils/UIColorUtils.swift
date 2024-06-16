//
//  UIColorUtils.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 10/06/24.
//

import UIKit

// MARK: - Utils for UIColor
extension UIColor {

    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 1
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let red = CGFloat((rgbValue & 0xff0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0xff00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0xff) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
