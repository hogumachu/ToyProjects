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
        
        let infoDetailViewControllerFactory: (Info) -> InfoDetailViewController = { info in
            return .init(dependency: .init(info: info), payload: ())
        }
        
        let coordinator = Coordinator.init(dependency:
                                            .init(mainViewControllerFactory: mainViewControllerFactory,
                                                  chatViewControllerFactory: chatViewControllerFactory,
                                                  infoViewControllerFactory: infoViewControllerFactory,
                                                  infoDetailViewControllerFactory: infoDetailViewControllerFactory),
                                           payload: ())
        
        return .init(coordinator: coordinator)
    }
}
