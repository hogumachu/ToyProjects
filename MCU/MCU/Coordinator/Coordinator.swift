import UIKit
class Coordinator {
    struct Dependency {
        let mainViewControllerFactory: () -> MainViewController
    }
    
    var naviagationController: UINavigationController?
    
    let mainViewControllerFactory: () -> MainViewController
    
    required init(dependency: Dependency) {
        mainViewControllerFactory = dependency.mainViewControllerFactory
    }
    
    func sceneChange(scene: Scene = .none, style: SceneTransitionStyle, animated: Bool) {
        if scene == .none && !(style == .dismiss || style == .pop) {
            return
        }
        
        let vc = sceneSelect(scene: scene)
        
        switch style {
        case .root:
            naviagationController?.setViewControllers([vc], animated: animated)
        case .modal:
            naviagationController?.present(vc, animated: animated)
        case .push:
            naviagationController?.pushViewController(vc, animated: animated)
        case .dismiss:
            naviagationController?.dismiss(animated: animated)
        case .pop:
            naviagationController?.popViewController(animated: animated)
        }
    }
    
    private func sceneSelect(scene: Scene) -> UIViewController {
        switch scene {
        case .none:
            return UIViewController()
        case .mainViewController:
            let vc = mainViewControllerFactory()
            vc.coordinator = self
            return vc
        }
    }
}

enum Scene {
    case none
    case mainViewController
}

enum SceneTransitionStyle {
    case root
    case modal
    case push
    case dismiss
    case pop
}
