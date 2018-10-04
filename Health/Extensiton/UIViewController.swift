import UIKit
import SVProgressHUD

extension UIViewController {
    class func getFrontViewController() -> UIViewController {
        var viewController = UIApplication.shared.keyWindow?.rootViewController
        while let vc = viewController?.presentedViewController {
            viewController = vc
        }

        return viewController!
    }

    class func getOptionalFrontViewController() -> UIViewController? {
        var viewController = UIApplication.shared.keyWindow?.rootViewController
        while let vc = viewController?.presentedViewController {
            viewController = vc
        }

        return viewController
    }

    func findParent<T: UIViewController>(type: T.Type) -> T? {
        if let parent = parent {
            if let target = parent as? T {
                return target
            } else {
                return parent.findParent(type: T.self)
            }
        } else {
            return nil
        }
    }
}


extension UIViewController {
    func showCloseAlert(_ title: String, _ message: String, _ closeAction: (() -> Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "CLOSE".localized, style: .default) { _ in
            closeAction?()
        }
        alertVC.addAction(closeAction)
        present(alertVC, animated: true, completion: nil)
    }

    func showOkAlert(_ title: String, _ message: String, _ okAction: (() -> Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK".localized, style: .default) { _ in
            okAction?()
        }
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }

    func showOkCancelAlert(_ title: String, _ message: String, _ okAction: (() -> Void)?, _ cancelAction: (() -> Void)? = nil,
                           cancelBtnTitle: String = "CANCEL".localized,
                           okBtnTitle: String = "OK".localized) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okBtnTitle, style: .default) { _ in
            okAction?()
        }
        alertVC.addAction(okAction)
        let cancelAction = UIAlertAction(title: cancelBtnTitle, style: .default) { _ in
            cancelAction?()
        }
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true, completion: nil)
    }

    func showAlert(_ title: String, _ message: String, _ okTitle: String, _ okAction: (() -> Void)?, _ cancelTitle: String?, _ cancelAction: (() -> Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default) { _ in
            okAction?()
        }
        alertVC.addAction(okAction)
        if cancelTitle != nil {
            let cancelAction = UIAlertAction(title: cancelTitle!, style: .default) { _ in
                cancelAction?()
            }
            alertVC.addAction(cancelAction)
        }
        present(alertVC, animated: true, completion: nil)
    }

    func showErrorAlert(_ message: String? = nil, action: (() -> Void)? = nil) {
        showOkAlert("ERROR".localized, message ?? "", action)
    }

    func showErrorAlert(_ error: Error?, action: (() -> Void)? = nil) {
        showErrorAlert(error?.localizedDescription, action: action)
    }

    func showMessage(_ message: String?) {
        let alertView = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        present(alertView, animated: true, completion: nil)
    }
}
