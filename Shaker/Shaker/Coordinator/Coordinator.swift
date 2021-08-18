import UIKit

class Coordinator {
    struct Dependency {
        let mainViewControllerFactory: () -> MainViewController
    }
    
    var navigationController: UINavigationController?
    
    let rootViewController: MainViewController
    
    required init(dependency: Dependency, payload: ()) {
        rootViewController = dependency.mainViewControllerFactory()
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.setViewControllers([rootViewController], animated: false)
    }
}
