import UIKit

class Coordinator {
    func start(window: UIWindow, rootViewController: UIViewController) {
        let rootViewController = UINavigationController(rootViewController: rootViewController)
        rootViewController.navigationBar.isHidden = true
        window.rootViewController = rootViewController
    }
}
