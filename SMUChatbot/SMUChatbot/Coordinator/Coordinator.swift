import UIKit

class Coordinator {
    struct Dependency {
        let mainViewControllerFactory: () -> MainViewController
        let chatViewControllerFactory: () -> ChatViewController
        let infoViewControllerFactory: () -> InfoViewController
        let infoDetailUseViewControllerFactory: (Info) -> InfoDetailUseViewController
        let infoDetailTeamViewControllerFactory: (Info) -> InfoDetailTeamViewController
//        let infoDetailViewControllerFactory: (Info) -> InfoDetailViewController
    }
    
    var navigationController: UINavigationController?
    
    let rootViewController: MainViewController
    let chatViewControllerFactory: () -> ChatViewController
    let infoViewControllerFactory: () -> InfoViewController
    let infoDetailUseViewControllerFactory: (Info) -> InfoDetailUseViewController
    let infoDetailTeamViewControllerFactory: (Info) -> InfoDetailTeamViewController
//    let infoDetailViewControllerFactory: (Info) -> InfoDetailViewController
    
    required init(dependency: Dependency, payload: ()) {
        rootViewController = dependency.mainViewControllerFactory()
        chatViewControllerFactory = dependency.chatViewControllerFactory
        infoViewControllerFactory = dependency.infoViewControllerFactory
        infoDetailUseViewControllerFactory = dependency.infoDetailUseViewControllerFactory
        infoDetailTeamViewControllerFactory = dependency.infoDetailTeamViewControllerFactory
//        infoDetailViewControllerFactory = dependency.infoDetailViewControllerFactory
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
        
    }
    
    func chatViewBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func infoDetailViewSelected(cellNumber: Int, info: Info) {
        switch cellNumber {
        case 0:
            let vc = infoDetailUseViewControllerFactory(info)
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = infoDetailTeamViewControllerFactory(info)
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = chatViewControllerFactory()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        default:
            print("Cell Select Error", #function)
        }
//        let vc = infoDetailViewControllerFactory(info)
//        navigationController?.pushViewController(vc, animated: true)
        
    }
}
