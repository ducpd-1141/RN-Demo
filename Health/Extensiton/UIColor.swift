import UIKit

extension UIColor {

    static var euBlue: UIColor {
        return rgba(46, green: 201, blue: 251)
    }

    static var euGray: UIColor {
        return rgba(74, green: 74, blue: 74)
    }

    static var euGreen: UIColor {
        return hex("#50E3C2")
    }

    static var euYellow: UIColor {
        return hex("#FFEC00")
    }

    static var gray: UIColor {
        return hex("#9B9B9B")
    }

    static var pink: UIColor {
        return hex("#FF33C0")
    }

    static var euAzureBlue: UIColor {
        return hex("#0576F9")
    }

    static var euLemonYellow: UIColor {
        return hex("#F8E71C")
    }

    static var textPlaceHolder: UIColor {
        return rgba(255, green: 255, blue: 255, alpha: 0.3)
    }

    static var euLightGray: UIColor {
        return rgba(155, green: 155, blue: 155)
    }

    static var euPink: UIColor {
        return rgba(255, green: 51, blue: 192)
    }

    static func rgba(_ red: Int?, green: Int?, blue: Int?, alpha: CGFloat = 1.0) -> UIColor {

        guard let r = red, let g = green, let b = blue else {
            return .white
        }

        let denominator: CGFloat = 255.0
        let color = UIColor(red: CGFloat(r) / denominator, green: CGFloat(g) / denominator, blue: CGFloat(b) / denominator, alpha: alpha)
        return color
    }

    static func hex(_ hexStr: String, alpha: CGFloat = 1) -> UIColor {
        let scanner = Scanner(string: hexStr.replacingOccurrences(of: "#", with: ""))
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red: r, green: g, blue: b, alpha: alpha)
        } else {
            return .white
        }
    }

    var hexString: NSString {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb: Int = (Int)(r * 255) << 16 | (Int)(g * 255) << 8 | (Int)(b * 255) << 0

        return NSString(format: "#%06x", rgb)
    }
}
