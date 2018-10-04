import UIKit

extension UIView {

    // swiftlint:disable force_cast
    class func loadFromNib<T: UIView>(_ type: T.Type, bundle: Bundle = Bundle.main) -> T {
        return bundle.loadNibNamed(type.className, owner: self, options: nil)?.first as! T
    }

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }

    public func border(color: UIColor, width: CGFloat) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.cornerRadius = corner
        layer.masksToBounds = true
    }

    public var corner: CGFloat {
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
        get {
            return layer.cornerRadius
        }
    }

    public func circle() {
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
        layer.masksToBounds = true
    }

    func parentView<T: UIView>(of type: T.Type) -> T? {
        guard let view = self.superview else {
            return nil
        }
        return (view as? T) ?? view.parentView(of: T.self)
    }

    func roundLeft() {
        let mask = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: [.topLeft, .bottomLeft],
                                cornerRadii: CGSize(width: bounds.height / 2, height: bounds.height / 2))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = mask.cgPath
        layer.mask = maskLayer
    }

    func roundTop(corner: CGFloat = 0.0) {
        let rightCornet = corner != 0.0 ? corner : bounds.height / 2
        let mask = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: rightCornet, height: rightCornet))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = mask.cgPath
        layer.mask = maskLayer
    }

    func roundRight() {
        let mask = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: [.topRight, .bottomRight],
                                cornerRadii: CGSize(width: bounds.height / 2, height: bounds.height / 2))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = mask.cgPath
        layer.mask = maskLayer
    }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

    func roundedTopEdge(desiredCurve: CGFloat? = nil) {
        let bounds = CGRect(origin: .zero, size: CGSize(width: self.bounds.width, height: UIScreen.main.bounds.height))
        let rectBounds = CGRect(x: bounds.origin.x, y: bounds.origin.y + bounds.size.height / 2, width: bounds.size.width, height: bounds.size.height / 2)
        let rectPath = UIBezierPath(rect: rectBounds)
        let ovalBounds = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height)
        let ovalPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        self.layer.mask = maskLayer
    }

    func mask(withRect rect: CGRect, inverse: Bool = false) {
        let path = UIBezierPath(rect: rect)
        let maskLayer = CAShapeLayer()

        if inverse {
            path.append(UIBezierPath(rect: self.bounds))
            maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
            path.usesEvenOddFillRule = true
        }

        maskLayer.path = path.cgPath

        self.layer.mask = maskLayer
    }

    func mask(withPath path: UIBezierPath, inverse: Bool = false) {
        let path = path
        let maskLayer = CAShapeLayer()

        if inverse {
            path.append(UIBezierPath(rect: self.bounds))
            maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        }

        maskLayer.path = path.cgPath

        self.layer.mask = maskLayer
    }
}
