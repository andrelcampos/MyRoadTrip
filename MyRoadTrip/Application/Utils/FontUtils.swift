//
//  FontUtils.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 10/06/24.
//

import Foundation
import UIKit

// MARK: - Implementation Details

public struct FontConvertible {
  public let name: String
  public let family: String
  public let path: String

  public func font(size: CGFloat) -> UIFont? {
    return UIFont(font: self, size: size)
  }

  public func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    let bundle = Bundle(for: BundleToken.self)
    return bundle.url(forResource: path, withExtension: nil)
  }
}

public extension UIFont {
  convenience init?(font: FontConvertible, size: CGFloat) {
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    self.init(name: font.name, size: size)
  }
}

private final class BundleToken {}
