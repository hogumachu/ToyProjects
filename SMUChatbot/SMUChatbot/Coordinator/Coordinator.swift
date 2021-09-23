import UIKit

class Coordinator {
    struct Dependency {
        let mainViewControllerFactory: () -> MainViewController
        let chatViewControllerFactory: () -> ChatViewController
        let infoViewControllerFactory: () -> InfoViewController
        let infoDetailUseViewControllerFactory: () -> InfoDetailUseViewController
        let infoDetailTeamViewControllerFactory: () -> InfoDetailTeamViewController
    }
    
    var navigationController: UINavigationController?
    
    let rootViewController: MainViewController
    let chatViewControllerFactory: () -> ChatViewController
    let infoViewControllerFactory: () -> InfoViewController
    let infoDetailUseViewControllerFactory: () -> InfoDetailUseViewController
    let infoDetailTeamViewControllerFactory: () -> InfoDetailTeamViewController
    
    required init(dependency: Dependency, payload: ()) {
        rootViewController = dependency.mainViewControllerFactory()
        chatViewControllerFactory = dependency.chatViewControllerFactory
        infoViewControllerFactory = dependency.infoViewControllerFactory
        infoDetailUseViewControllerFactory = dependency.infoDetailUseViewControllerFactory
        infoDetailTeamViewControllerFactory = dependency.infoDetailTeamViewControllerFactory
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
    
    func chatViewBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func infoDetailViewSelected(cellNumber: Int) {
        switch cellNumber {
        case 0:
            let vc = infoDetailUseViewControllerFactory()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = infoDetailTeamViewControllerFactory()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = chatViewControllerFactory()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        default:
            print("Cell Select Error", #function)
        }
    }
}
