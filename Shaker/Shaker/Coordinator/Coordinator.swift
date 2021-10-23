import UIKit

class Coordinator {
    struct Dependency {
        let mainViewControllerFactory: () -> MainViewController
        let searchViewControllerFactory: () -> SearchViewController
        let mapViewControllerFactory: () -> MapViewController
    }
    
    var navigationController: UINavigationController?
    
    let rootViewController: MainViewController
    
    let searchViewController: SearchViewController
    
    let mapViewController: MapViewController
    
    required init(dependency: Dependency, payload: ()) {
        rootViewController = dependency.mainViewControllerFactory()
        searchViewController = dependency.searchViewControllerFactory()
        mapViewController = dependency.mapViewControllerFactory()
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.isNavigationBarHidden = true
        navigationController?.setViewControllers([rootViewController], animated: false)
    }
    
    func pushSearchViewController(searchText: String) {
        searchViewController.title = searchText
        searchViewController.searchText = searchText
        navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    func pushMapViewController() {
        navigationController?.pushViewController(mapViewController, animated: true)
    }
}
