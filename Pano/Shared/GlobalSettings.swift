//
//  GlobalSettings.swift
//  Pano
//
//  Created by AliReza on 2023-02-06.
//

import UIKit

final class GlobalSettings {
    
    // MARK: - Shared Instance
    
    static let shared = GlobalSettings()
    
    // MARK: - Fonts Enum
    
    enum FontType: String {
        case black = "Poppins-Black"
        case blackItalic = "Poppins-BlackItalic"
        case bold = "Poppins-Bold"
        case boldItalic = "Poppins-BoldItalic"
        case extraBold = "Poppins-ExtraBold"
        case extraBoldItalic = "Poppins-ExtraBoldItalic"
        case extraLight = "Poppins-ExtraLight"
        case extraLightItalic = "Poppins-ExtraLightItalic"
        case italic = "Poppins-Italic"
        case light = "Poppins-Light"
        case lightItalic = "Poppins-LightItalic"
        case medium = "Poppins-Medium"
        case mediumItalic = "Poppins-MediumItalic"
        case regular = "Poppins-Regular"
        case semiBold = "Poppins-SemiBold"
        case semiBoldItalic = "Poppins-SemiBoldItalic"
        case thin = "Poppins-Thin"
        case thinItalic = "Poppins-ThinItalic"
    }
    
    // MARK: - Colors
    let darkGray = UIColor(named: "darkGray")
    let purple = UIColor(named: "purple")
    let red = UIColor(named: "red")
    
    // MARK: - Fonts
    
    func getFont(withType type: FontType = .regular, ofSize size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size) ?? UIFont()
    }
    
}
