import UIKit

class Coordinator {
    
    struct Dependency {
        let mainViewControllerFactory: () -> MainViewController
        let chatViewControllerFactory: () -> ChatViewController
        let infoViewControllerFactory: () -> InfoViewController
        let infoDetailViewControllerFactory: (Info) -> InfoDetailViewController
    }
    
    var navigationController: UINavigationController?
    
    let rootViewController: MainViewController
    let chatViewControllerFactory: () -> ChatViewController
    let infoViewControllerFactory: () -> InfoViewController
    let infoDetailViewControllerFactory: (Info) -> InfoDetailViewController
    
    required init(dependency: Dependency, payload: ()) {
        rootViewController = dependency.mainViewControllerFactory()
        chatViewControllerFactory = dependency.chatViewControllerFactory
        infoViewControllerFactory = dependency.infoViewControllerFactory
        infoDetailViewControllerFactory = dependency.infoDetailViewControllerFactory
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.navigationBar.isHidden = true
        navigationController?.setViewControllers([rootViewController], animated: false)
    }
    
    func gotoInfoViewController() {
        let vc = infoViewControllerFactory()
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func chatViewSelected() {
        let vc = chatViewControllerFactory()
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func chatViewBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func infoDetailViewSelected(info: Info) {
        let vc = infoDetailViewControllerFactory(info)
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
