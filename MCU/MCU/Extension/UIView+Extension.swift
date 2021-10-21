import UIKit

extension UIView {
    func addSubviewsAndAutoresizingFalse(_ uiviews: UIView...) {
        uiviews.forEach { uv in
            self.addSubview(uv)
            uv.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
