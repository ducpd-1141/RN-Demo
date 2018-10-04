import UIKit

public enum AlertLevel: Int {
    case low
    case normal
    case high
    case require
}
protocol AlertLevelProtocol: class {
    var level: AlertLevel { get }
    func dismiss(animated: Bool, completion: (() -> Void)?)
}

open class AlertController: UIAlertController, AlertLevelProtocol {

    var level = AlertLevel.normal

    func addAction(_ title: String?, style: UIAlertAction.Style = UIAlertAction.Style.default, handler: (() -> Void)? = nil) {
        let actionHandler: ((UIAlertAction) -> Void)? = handler != nil ? { (action: UIAlertAction) -> Void in
            handler?()
        }: nil
        let action = UIAlertAction(title: title, style: style, handler: actionHandler)
        addAction(action)
    }

    // Recommend `present` method for AlertController instead of default is `presentViewController`.
    func present(from: UIViewController? = nil, animated: Bool = true, completion: (() -> Void)? = nil) {
        if let from = from, from.isViewLoaded {
            if let popup = from.presentedViewController {
                if let vc = popup as? AlertLevelProtocol {
                    if level > vc.level {
                        vc.dismiss(animated: animated, completion: { () -> Void in
                            self.present(from: from, animated: animated, completion: completion)
                        })
                    }
                } else if level > .normal {
                    popup.dismiss(animated: animated, completion: { () -> Void in
                        self.present(from: from, animated: animated, completion: completion)
                    })
                }
            } else {
                from.present(self, animated: animated, completion: completion)
            }
        } else if let root = UIApplication.shared.delegate?.window??.rootViewController, root.isViewLoaded {
            present(from: root, animated: animated, completion: completion)
        }
    }

    func dismiss(_ animated: Bool = true, completion: (() -> Void)? = nil) {
        self.dismiss(animated: animated, completion: completion)
    }

    class func alertWithError(_ error: NSError, title: String, level: AlertLevel = .normal, handler: (() -> Void)? = nil) -> AlertController {
        let alert = AlertController(
            title: title,
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction("OK", style: .cancel, handler: handler)
        return alert
    }
}

public func == (lhs: AlertLevel, rhs: AlertLevel) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

public func > (lhs: AlertLevel, rhs: AlertLevel) -> Bool {
    return lhs.rawValue > rhs.rawValue
}

public func >= (lhs: AlertLevel, rhs: AlertLevel) -> Bool {
    return lhs.rawValue >= rhs.rawValue
}

public func < (lhs: AlertLevel, rhs: AlertLevel) -> Bool {
    return lhs.rawValue < rhs.rawValue
}

public func <= (lhs: AlertLevel, rhs: AlertLevel) -> Bool {
    return lhs.rawValue <= rhs.rawValue
}
