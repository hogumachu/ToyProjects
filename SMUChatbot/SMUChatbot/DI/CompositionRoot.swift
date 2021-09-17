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
        
//        let infoDetailViewControllerFactory: (Info) -> InfoDetailViewController = { info in
//            return .init(dependency: .init(info: info), payload: ())
//        }
        
        let infoDetailUseViewControllerFactory: (Info) -> InfoDetailUseViewController = { info in
            return .init(dependency: .init(info: info), payload: ())
        }
        
        let infoDetailTeamViewControllerFactory: (Info) -> InfoDetailTeamViewController = { info in
            return .init(dependency: .init(info: info), payload: ())
        }
        
        let coordinator = Coordinator.init(dependency:
                                            .init(mainViewControllerFactory: mainViewControllerFactory,
                                                  chatViewControllerFactory: chatViewControllerFactory,
                                                  infoViewControllerFactory: infoViewControllerFactory,
                                                  infoDetailUseViewControllerFactory : infoDetailUseViewControllerFactory,
                                                  infoDetailTeamViewControllerFactory: infoDetailTeamViewControllerFactory
                                            ),
                                           payload: ())
        
        return .init(coordinator: coordinator)
    }
}
