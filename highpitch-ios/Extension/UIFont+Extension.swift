//
//  UIFont+Extension.swift
//  highpitch-ios
//
//  Created by yuncoffee on 3/3/24.
//

import Foundation
import UIKit

extension UIFont {
    static func pretendard(name: PretendardFont, size: CGFloat) -> UIFont {
        UIFont(name: name.rawValue, size: size) ?? .preferredFont(forTextStyle: .body)
    }
    
    static func pretendard(_ scale: PretendardScale, weight: PretendardFont) -> UIFont {
        UIFont(name: weight.rawValue, size: scale.rawValue) ?? .preferredFont(forTextStyle: .body)
    }
    
    struct Pretendard {
        struct LargeTitle {}
        struct Title1 {
            static let bold = UIFont(name: PretendardFont.bold.rawValue, size: 24)
            static let medium = UIFont(name: PretendardFont.medium.rawValue, size: 24)
        } // 24
        struct Title2 {
            static let bold = UIFont(name: PretendardFont.bold.rawValue, size: 20)
            static let semibold = UIFont(name: PretendardFont.semiBold.rawValue, size: 20)
        }// 20
        struct Title3 {
            static let semibold = UIFont(name: PretendardFont.semiBold.rawValue, size: 18)
        }// 18
        struct Headline {
            static let bold = UIFont(name: PretendardFont.bold.rawValue, size: 16)
            static let semibold = UIFont(name: PretendardFont.semiBold.rawValue, size: 16)
            static let medium = UIFont(name: PretendardFont.medium.rawValue, size: 16)
        } // 16
        struct Body {
            static let meiudm = UIFont(name: PretendardFont.medium.rawValue, size: 14)
            static let regular = UIFont(name: PretendardFont.regular.rawValue, size: 14)
        } // 14
//        struct Callout {}
//        struct SubHead {}
        struct Footnote {} // 13
        struct Caption1 {
            static let bold = UIFont(name: PretendardFont.bold.rawValue, size: 12)
            static let semibold = UIFont(name: PretendardFont.semiBold.rawValue, size: 12)
            static let regular = UIFont(name: PretendardFont.regular.rawValue, size: 12)
        } // 12
        struct Caption2 {} // 10
        
        static func registerFonts() {
            PretendardFont.allCases.forEach { registerFont(bundle: .main, 
                                                           fontName: $0.rawValue,
                                                           fontExtension: "otf") }
        }
    }
}

func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
    guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
          let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
          let font = CGFont(fontDataProvider) else {
        fatalError("Could't create font from filename: \(fontName) with extension \(fontExtension)")
    }
    var error: Unmanaged<CFError>?
    CTFontManagerRegisterGraphicsFont(font, &error)
}

enum PretendardFont: String, CaseIterable {
    case black = "Pretendard-Black"
    case regular = "Pretendard-Regular"
    case bold = "Pretendard-Bold"
    case medium = "Pretendard-Medium"
    case light = "Pretendard-Light"
    case semiBold = "Pretendard-SemiBold"
}

enum PretendardScale: CGFloat, CaseIterable {
    case largeTitle = 32
    case title1 = 24
    case title2 = 20
    case title3 = 18
    case headline = 16
    case body = 14
    case footnote = 13
    case caption1 = 12
    case caption2 = 11
}
