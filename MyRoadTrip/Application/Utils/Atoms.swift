//
//  Atoms.swift
//  MyRoadTrip
//
//  Created by Andre Campos on 10/06/24.
//

import Foundation
import UIKit

// MARK: - Atoms Color
extension UIColor {
    
    /// Cinza Claro (Fundo Secundário):
    /// Uso: Fundo de cartões, caixas de texto, elementos secundários.
    static let mainBg           = UIColor(hex: "#F1FAEE")
    
    /// Azul Médio (Botões Primários):
    /// Uso: Botões principais, links.
    static let mainBtn          = UIColor(hex: "#457B9D")

    /// Verde Claro (Elementos de Destaque):
    /// Uso: Destaques, botões secundários, ícones.
    static let mainHilighted    = UIColor(hex: "#2A9D8F")

    /// Azul Escuro (Texto Principal):
    /// Uso: Texto principal, títulos.
    static let mainTxt          = UIColor(hex: "#1D3557")

    /// Azul Claro (Background Principal):
    /// Uso: Fundo principal do aplicativo.
    static let secondaryBg      = UIColor(hex: "#A8DADC")

    /// Branco (Texto Secundário):
    /// Uso: Texto em botões, texto em fundos escuros.
    static let secondaryTxt     = UIColor(hex: "#FFFFFF")
}

// MARK: - Atoms Font
enum Font {
    static let montserratBold = FontConvertible(name: "Montserrat-Bold", family: "Montserrat", path: "Montserrat-Bold.ttf")
    static let poppinsSemiBold = FontConvertible(name: "Poppins-SemiBold", family: "Poppins", path: "Poppins-SemiBold.ttf")
    static let robotoRegular = FontConvertible(name: "Roboto-Regular", family: "Roboto", path: "Roboto-Regular.ttf")
}

import UIKit

// MARK: TextStyle
class TextStyle {
    var baseFont: FontConvertible
    var color: UIColor
    var alignment: NSTextAlignment
    var fontSize: CGFloat
    
    init(font: FontConvertible, color: UIColor, alignment: NSTextAlignment = .natural, fontSize: CGFloat) {
        self.baseFont = font
        self.color = color
        self.alignment = alignment
        self.fontSize = fontSize
    }
    
    func font() -> UIFont? {
        return baseFont.font(size: fontSize)
    }
    func style() -> [NSAttributedString.Key: Any] {
        var style = [NSAttributedString.Key: Any]()
        style[NSAttributedString.Key.font] = baseFont.font(size: fontSize)
        
        let paragraphStyle = NSMutableParagraphStyle()

        paragraphStyle.lineHeightMultiple = 2
        paragraphStyle.alignment = alignment

        style[NSAttributedString.Key.paragraphStyle] = paragraphStyle
    
        return style
    }
}

extension TextStyle {
    
    /// Font: montserratBold - Size: 26 - Color: #1D3557 mainTxt
    static let title1 = TextStyle(font: Font.montserratBold, color: .mainTxt, fontSize: 26)

    /// Font: montserratBold - Size: 20 - Color: #1D3557 mainTxt
    static let listTitle = TextStyle(font: Font.montserratBold, color: .mainTxt, fontSize: 20)

    /// Font: robotoRegular - Size: 14 - Color: #1D3557 mainTxt
    static let cardDesc = TextStyle(font: Font.robotoRegular, color: .mainTxt, fontSize: 14)
    
    /// Font: poppinsSemiBold - Size: 16 - Color: #1D3557 mainTxt
    static let cardTitle = TextStyle(font: Font.poppinsSemiBold, color: .mainTxt, fontSize: 16)
    
    /// Font: montserratBold - Size: 16 - Color: #1D3557 mainTxt
    static let cardTitle2 = TextStyle(font: Font.montserratBold, color: .mainTxt, fontSize: 16)
    
    /// Font: robotoRegular - Size: 16 - Color: #1D3557 mainTxt
    static let body1 = TextStyle(font: Font.robotoRegular, color: .mainTxt, fontSize: 16)
    
    /// Font: robotoRegular - Size: 22 - Color: #1D3557 mainTxt
    static let paragraph1 = TextStyle(font: Font.robotoRegular, color: .mainTxt, fontSize: 22)
    
    /// Font: robotoRegular - Size: 18 - Color: #457B9D mainBtn
    static let button1 = TextStyle(font: Font.robotoRegular, color: .mainBtn, fontSize: 18)
}
