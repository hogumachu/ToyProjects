import UIKit

class Coordinator {
    struct Dependency {
        let mainViewControllerFactory: () -> MainViewController
        let mapViewControllerFactory: () -> MapViewController
    }
    
    var navigationController: UINavigationController?
    
    let rootViewController: MainViewController
    
    let mapViewController: MapViewController
    
    required init(dependency: Dependency, payload: ()) {
        rootViewController = dependency.mainViewControllerFactory()
        mapViewController = dependency.mapViewControllerFactory()
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.setViewControllers([rootViewController], animated: false)
    }
    
    func pushMapViewController() {
        navigationController?.pushViewController(mapViewController, animated: true)
    }
}
