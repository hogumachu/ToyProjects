struct AppDependency {
    let coordinator: Coordinator
}

extension AppDependency {
    static func resolve() -> AppDependency {
        let mainViewControllerFactory: () -> MainViewController = {
            return .init(dependency: .init(viewModel: .init()), payload: ())
        }
        
        let coordinator = Coordinator.init(dependency: .init(mainViewControllerFactory: mainViewControllerFactory), payload: ())
        return .init(coordinator: coordinator)
    }
}
