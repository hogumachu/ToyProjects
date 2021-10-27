struct AppDependency {
    let coordinator: Coordinator
    let storage: Storable
}

extension AppDependency {
    static func resolve() -> AppDependency {
        let storage = ContentStorage()
        
        let mainViewControllerFactory: () -> MainViewController = {
            return .init(dependency:
                                .init(
                                    viewModel: .init(storage: storage)
                                )
            )
        }
        let detailViewControllerFactory: (Content) -> DetailViewController = { content in
            return .init(dependency:
                                .init(
                                    viewModel: .init(storage: storage, dependency: .init(content: content))
                                )
            )
        }
        
        return .init(
            coordinator: .init(
                .init(
                    mainViewControllerFactory: mainViewControllerFactory,
                    detailViewControllerFactory: detailViewControllerFactory
                )
            ),
            storage: storage
        )
    }
}
