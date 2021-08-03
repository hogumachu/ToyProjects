import UIKit

class Coordinator {
    
    struct Dependency {
        let mainViewControllerFactory: () -> MainViewController
        let chatViewControllerFactory: () -> ChatViewController
        let infoViewControllerFactory: () -> InfoViewController
    }
    
    var navigationController: UINavigationController?
    
    let rootViewController: MainViewController
    let chatViewControllerFactory: () -> ChatViewController
    let infoViewControllerFactory: () -> InfoViewController
    
    required init(dependency: Dependency, payload: ()) {
        rootViewController = dependency.mainViewControllerFactory()
        chatViewControllerFactory = dependency.chatViewControllerFactory
        infoViewControllerFactory = dependency.infoViewControllerFactory
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.navigationBar.isHidden = true
        navigationController?.setViewControllers([rootViewController], animated: false)
    }
    
    func startMainViewContoller() {
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
}
