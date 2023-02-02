//
//  Fonts.swift
//  MovieApp
//
//  Created by Cagla Efendioğlu on 30.01.2023.
//

import UIKit

final class Font {
    enum FontWeight {
        case light
        case regular
        case medium
        case semibold
        case bold
    }

    static func custom(size: CGFloat = 14, fontWeight: FontWeight = .medium) -> UIFont {
        return UIFont(name: "Poppins-\(fontWeight)",
                      size: size * UIScreen.main.bounds.height * 0.00115)!
    }
}
