import UIKit

class Coordinator {
    struct Dependency {
        let mainViewControllerFactory: () -> MainViewController
        let chatViewControllerFactory: () -> ChatViewController
        let infoViewControllerFactory: () -> InfoViewController
        let infoDetailTeamViewControllerFactory: () -> InfoDetailTeamViewController
        let infoDetailUseViewControllerFactory: () -> InfoDetailUseViewController
        let infoPopupViewControllerFactory: () -> InfoPopupViewController
        let webViewControllerFactory: (_ url: String) -> WebViewController
    }
    
    var navigationController: UINavigationController?
    
    let mainViewControllerFactory: () -> MainViewController
    let chatViewControllerFactory: () -> ChatViewController
    let infoViewControllerFactory: () -> InfoViewController
    let infoDetailTeamViewControllerFactory: () -> InfoDetailTeamViewController
    let infoDetailUseViewControllerFactory: () -> InfoDetailUseViewController
    let infoPopupViewControllerFactory: () -> InfoPopupViewController
    let webViewControllerFactory: (_ url: String) -> WebViewController
    
    required init(dependency: Dependency, payload: ()) {
        mainViewControllerFactory = dependency.mainViewControllerFactory
        chatViewControllerFactory = dependency.chatViewControllerFactory
        infoViewControllerFactory = dependency.infoViewControllerFactory
        infoDetailTeamViewControllerFactory = dependency.infoDetailTeamViewControllerFactory
        infoDetailUseViewControllerFactory = dependency.infoDetailUseViewControllerFactory
        infoPopupViewControllerFactory = dependency.infoPopupViewControllerFactory
        webViewControllerFactory = dependency.webViewControllerFactory
    }
    
    func start() {
        let vc = mainViewControllerFactory()
        
        vc.coordinator = self
        navigationController?.navigationBar.isHidden = true
        navigationController?.setViewControllers([vc], animated: false)
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
            let vc = infoDetailTeamViewControllerFactory()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = infoDetailUseViewControllerFactory()
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
    
    func infoPopup() {
        let vc = infoPopupViewControllerFactory()
        vc.coordinator = self
        vc.modalPresentationStyle = .overCurrentContext
        navigationController?.present(vc, animated: false, completion: nil)
    }
    
    func loadWebViewController(_ url: String) {
        let vc = webViewControllerFactory(url)
        vc.coordinator = self
        vc.modalPresentationStyle = .overCurrentContext
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    func sceneChange(scene: Scene = .none, style: SceneTransitionStyle, animated: Bool, url: String = "") {
        let vc = selectScene(scene: scene, url: url)
        
        switch style {
        case .push:
            navigationController?.pushViewController(vc, animated: animated)
        case .modal:
            navigationController?.present(vc, animated: animated)
        case .root:
            navigationController?.setViewControllers([vc], animated: animated)
        case .pop:
            navigationController?.popViewController(animated: animated)
        case .dismiss:
            navigationController?.topViewController?.dismiss(animated: animated)
        }
        
    }
    
    private func selectScene(scene: Scene, url: String) -> UIViewController {
        switch scene {
        case .none:
            return UIViewController()
        case .mainViewController:
            let vc = mainViewControllerFactory()
            navigationController?.navigationBar.isHidden = true
            vc.coordinator = self
            return vc
        case .chatViewController:
            let vc = chatViewControllerFactory()
            vc.coordinator = self
            return vc
        case .infoViewController:
            let vc = infoViewControllerFactory()
            vc.coordinator = self
            return vc
        case .infoDetailTeamViewController:
            let vc = infoDetailTeamViewControllerFactory()
            vc.coordinator = self
            return vc
        case .infoDetailUseViewController:
            let vc = infoDetailUseViewControllerFactory()
            vc.coordinator = self
            return vc
        case .infoPopupViewController:
            let vc = infoPopupViewControllerFactory()
            vc.modalPresentationStyle = .overCurrentContext
            vc.coordinator = self
            return vc
        case .webViewController:
            let vc = webViewControllerFactory(url)
            vc.modalPresentationStyle = .overCurrentContext
            vc.coordinator = self
            return vc
        }
    }
}

enum Scene {
    case none
    case mainViewController
    case chatViewController
    case infoViewController
    case infoDetailTeamViewController
    case infoDetailUseViewController
    case infoPopupViewController
    case webViewController
}

enum SceneTransitionStyle {
    case push
    case modal
    case root
    case pop
    case dismiss
}
