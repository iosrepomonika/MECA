
import UIKit
extension UIColor {
    class func getCustomRedColor() -> UIColor{
            return UIColor(red: 0.9882352941, green: 0, blue: 0, alpha: 1)
        }
        
    class func getCustomBlueColor() -> UIColor{
            return UIColor(red: 0.1490196078, green: 0.2784313725, blue: 0.5529411765, alpha: 1)
    }
    class func getCustomLightBlueColor() -> UIColor{
            return UIColor(red: 0.2392156863, green: 0.4823529412, blue: 0.831372549, alpha: 1)
    }
    
    class func getCustomOrangeColor() -> UIColor{
            return UIColor(red: 0.9803921569, green: 0.6235294118, blue: 0.2039215686, alpha: 1)
    }
    
    class func getCustomDarkOrangeColor() -> UIColor{
            return UIColor(red: 0.9650015235, green: 0.4383477867, blue: 0.2127818763, alpha: 1)
    }
class func colorFromHex(rgbValue:UInt32, alpha:Double = 1.0)->UIColor{
    let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
    let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
    let blue = CGFloat(rgbValue & 0xFF)/256.0
    return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
}
    
    class  func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
