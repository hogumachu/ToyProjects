struct AppDependency {
    let coordinator: Coordinator
}

extension AppDependency {
    static func resolve() -> AppDependency {
        let coordinator = Coordinator.init()
        return .init(coordinator: coordinator)
    }
}
