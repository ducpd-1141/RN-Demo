import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ aClass: T.Type) {
        let name = String(describing: aClass)
        let bundle = Bundle.main
        if bundle.path(forResource: name, ofType: "nib") != nil {
            let nib = UINib(nibName: name, bundle: bundle)
            register(nib, forCellReuseIdentifier: name)
        } else {
            register(aClass, forCellReuseIdentifier: name)
        }
    }

    func register<T: UITableViewHeaderFooterView>(_ aClass: T.Type) {
        let name = String(describing: aClass)
        let bundle = Bundle.main
        if bundle.path(forResource: name, ofType: "nib") != nil {
            let nib = UINib(nibName: name, bundle: bundle)
            register(nib, forHeaderFooterViewReuseIdentifier: name)
        } else {
            register(aClass, forHeaderFooterViewReuseIdentifier: name)
        }
    }

    func dequeue<T: UITableViewCell>(_ aClass: T.Type) -> T {
        let name = String(describing: aClass)
        guard let cell = dequeueReusableCell(withIdentifier: name) as? T else {
            fatalError("`\(name)` is not registed")
        }
        return cell
    }

    func dequeue<T: UITableViewHeaderFooterView>(_ aClass: T.Type) -> T {
        let name = String(describing: aClass)
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: name) as? T else {
            fatalError("`\(name)` is not registed")
        }
        return cell
    }

    func cellAtIndex<T: UITableViewCell>(_ type: T.Type, row: Int = 0, section: Int = 0) -> T {
        return cellForRow(at: IndexPath(row: row, section: section)) as! T
    }

    func cellAtOptionalIndex<T: UITableViewCell>(_ type: T.Type, row: Int = 0, section: Int = 0) -> T? {
        return cellForRow(at: IndexPath(row: row, section: section)) as? T
    }

    func setSeparetorZero(_ cell: UITableViewCell) {
        if responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            separatorInset = UIEdgeInsets.zero
        }

        if responds(to: #selector(setter: UIView.layoutMargins)) {
            layoutMargins = UIEdgeInsets.zero
        }

        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
    }

    func reloadDataAfter(_ completion: (() -> Void)? = nil) {
        reloadData()
        guard let comp = completion else { return }
        DispatchQueue.main.async(execute: { comp() })
    }

    func isLastCell(at indexPath: IndexPath) -> Bool {
        return indexPath.row == (numberOfRows(inSection: indexPath.section) - 1)
    }

    func isLastSectionAndLastRow(at indexPath: IndexPath) -> Bool {
        return indexPath.section == (numberOfSections - 1) && isLastCell(at: indexPath)
    }

    func lastIndexPath() -> IndexPath? {
        for index in (0 ..< numberOfSections).reversed() {
            if numberOfRows(inSection: index) > 0 {
                return IndexPath(row: numberOfRows(inSection: index) - 1, section: index)
            }
        }
        return nil
    }

    func scrollToBottom(animated: Bool) {
        guard let indexPath = lastIndexPath() else {
            return
        }
        scrollToRow(at: indexPath, at: .bottom, animated: animated)
    }
}
