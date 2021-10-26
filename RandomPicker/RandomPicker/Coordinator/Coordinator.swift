import UIKit

final class Coordinator {
    struct Dependency {
        let mainViewControllerFactory: () -> MainViewController
    }
    
    var navigationController: UINavigationController?
    let mainViewControllerFactory: () -> MainViewController
    
    init(_ dependency: Dependency) {
        self.mainViewControllerFactory = dependency.mainViewControllerFactory
    }
    
    func sceneChange(scene: Scene, style: SceneTransitionStyle, animated: Bool) {
        let vc = sceneSelect(scene)
        
        switch style {
        case .root:
            navigationController?.setViewControllers([vc], animated: animated)
        case .modal:
            navigationController?.present(vc, animated: animated, completion: nil)
        case .push:
            navigationController?.pushViewController(vc, animated: animated)
        case .dismiss:
            navigationController?.dismiss(animated: animated, completion: nil)
        case .pop:
            navigationController?.popViewController(animated: animated)
        }
    }
    
    private func sceneSelect(_ scene: Scene) -> UIViewController {
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
