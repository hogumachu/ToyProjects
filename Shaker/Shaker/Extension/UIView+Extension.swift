import UIKit

extension UIView {
    func addSubviews(_ uiViews: UIView...) {
        uiViews.forEach { view in
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
