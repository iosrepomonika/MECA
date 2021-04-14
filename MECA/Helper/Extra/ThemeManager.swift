
import Foundation
import UIKit

enum Theme: Int {
    
    case light, dark
  
    var white: UIColor {
        switch self {
        case .light:
            return UIColor.colorFromHex(rgbValue: 0xFFFFFF)
        case .dark:
            return UIColor.colorFromHex(rgbValue: 0xFFFFFF)
        }
    }

    var black: UIColor {
        switch self {
        case .light:
            return UIColor.colorFromHex(rgbValue: 0x000000)
        case .dark:
            return UIColor.colorFromHex(rgbValue: 0x000000)
        }
    }

    var barStyle: UIBarStyle {
        switch self {
        case .light:
            return .default
        case .dark:
            return .default
        }
    }
    var watermelon: UIColor {
        switch self {
        case .light:
            return #colorLiteral(red: 0.946038425, green: 0.4153085351, blue: 0.2230136693, alpha: 1) //UIColor.colorFromHex(rgbValue: 0xce0e2d)
        case .dark:
            return #colorLiteral(red: 0.946038425, green: 0.4153085351, blue: 0.2230136693, alpha: 1) //UIColor.colorFromHex(rgbValue: 0xff1140)
        }
    }//
}
// Enum declaration
let SelectedThemeKey = "SelectedTheme"

class ThemeManager {
    // ThemeManager

    static func currentTheme() -> Theme {
        if let storedTheme = (UserDefaults.standard.value(forKey: SelectedThemeKey) as AnyObject).integerValue {
            return Theme(rawValue: storedTheme)!
        } else {
            return .light
        }
    }
}

