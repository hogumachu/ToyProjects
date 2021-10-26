struct AppDependency {
    let coordinator: Coordinator
    let storage: Storable
}

extension AppDependency {
    static func resolve() -> AppDependency {
        let storage = ContentStorage()
        
        let mainViewControllerFactory: () -> MainViewController = {
            return .init(dependency: .init(viewModel: .init(storage: storage)))
        }
        
        return .init(
            coordinator: .init(
                .init(
                    mainViewControllerFactory: mainViewControllerFactory
                )
            ),
            storage: storage
        )
    }
}
