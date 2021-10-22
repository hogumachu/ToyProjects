import UIKit

extension UIView {
    func addSubviews(_ uiViews: UIView...) {
        uiViews.forEach { uv in
            uv.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(uv)
        }
    }
}
