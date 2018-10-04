import UIKit

extension UITableViewCell {
    open override func awakeFromNib() {
        super.awakeFromNib()
        layoutMargins = UIEdgeInsets.zero
    }

    var superTableView: UITableView? {
        return self.parentView(of: UITableView.self)
    }
}
