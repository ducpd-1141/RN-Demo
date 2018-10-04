import UIKit

extension UITextField {
    func setup(font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment = .left) {
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
    }

    func setColorPlaceholder(text: String, color: UIColor) {
        self.attributedPlaceholder = NSAttributedString(string: text,
                                                        attributes: [NSAttributedString.Key.foregroundColor: color])
    }

    func isWhiteSpaceOrEmpty() -> Bool {
        return text?.isWhiteSpaceOrEmpty() ?? false
    }
}
