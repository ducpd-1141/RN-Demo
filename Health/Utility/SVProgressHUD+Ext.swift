import Foundation
import RxSwift
import RxCocoa
import SVProgressHUD

public extension Reactive where Base: UIViewController {
    var isLoading: Binder<Bool> {
        return Binder(UIApplication.shared) { _, isVisible in
            if isVisible {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss(withDelay: 0.3)
            }
        }
    }
}

extension Reactive where Base: SVProgressHUD {
    public static var isAnimating: Binder<Bool> {
        return Binder(UIApplication.shared) { _, isVisible in
            if isVisible {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }
    }
}

extension UIViewController {
    func showProgress() {
        SVProgressHUD.show()
    }

    func showError(with message: String?) {
        SVProgressHUD.showError(withStatus: message)
        SVProgressHUD.dismiss(withDelay: 2.0)
    }

    func dismissProgress(with delay: Double?) {
        if let delay = delay {
            SVProgressHUD.dismiss(withDelay: delay)
        } else {
            SVProgressHUD.dismiss()
        }
    }
}
