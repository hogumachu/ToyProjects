struct AppDependency {
    let coordinator: Coordinator
}

extension AppDependency {
    static func resolve() -> AppDependency {
        let mainViewControllerFactory: () -> MainViewController = {
            return .init(dependency: .init(viewModel: .init()), payload: ())
        }
        
        let searchViewControllerFactory: () -> SearchViewController = {
            return .init(dependency: .init(viewModel: .init()), payload: ())
        }
        
        let mapViewControllerFactory: () -> MapViewController = {
            return .init()
        }
        
        let coordinator = Coordinator.init(dependency: .init(mainViewControllerFactory: mainViewControllerFactory,
                                                             searchViewControllerFactory: searchViewControllerFactory,
                                                             mapViewControllerFactory: mapViewControllerFactory),
                                           payload: ())
        return .init(coordinator: coordinator)
    }
}
