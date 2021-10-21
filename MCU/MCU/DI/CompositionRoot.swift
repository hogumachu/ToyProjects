struct AppDependency {
    let coordinator: Coordinator
}

extension AppDependency {
    static func resolve() -> AppDependency {
        let mainViewControllerFactory: () -> MainViewController = {
            return .init(dependency: .init(viewModel: .init()))
        }
        
        let coordinator = Coordinator(dependency: .init(mainViewControllerFactory: mainViewControllerFactory))
        
        return .init(coordinator: coordinator)
    }
}
