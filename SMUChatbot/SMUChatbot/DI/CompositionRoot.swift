struct AppDependency {
    let coordinator: Coordinator
}

extension AppDependency {
    static func resolve() -> AppDependency {
        
        let mainViewControllerFactory: () -> MainViewController = {
            return .init(dependency: .init(viewModel: .init()), payload: ())
        }
        
        let chatViewControllerFactory: () -> ChatViewController = {
            return .init(dependency: .init(viewModel: .init()), payload: ())
        }
        
        let infoViewControllerFactory: () -> InfoViewController = {
            return .init(dependency: .init(viewModel: .init()), payload: ())
        }
        
        let coordinator = Coordinator.init(dependency: .init(mainViewControllerFactory: mainViewControllerFactory, chatViewControllerFactory: chatViewControllerFactory, infoViewControllerFactory: infoViewControllerFactory), payload: ())
        
        return .init(coordinator: coordinator)
    }
}
