import UIKit

struct AppDependency {
    let mainCoordinator: Coordinator
}

extension AppDependency {
    static func resolve() -> AppDependency {
        let storage = MovieStorage()
        
        let mainNavigationController = UINavigationController()
        
        let mainViewControllerFactory: (MainViewController.Dependency) -> MainViewController = { dependency in
            return .init(dependency: dependency)
        }
        
        let movieListViewControllerFactory: (MovieListViewController.Dependency) -> MovieListViewController = { dependency in
            return .init(dependency: dependency)
        }
        
        let movieDetailViewControllerFactory: (MovieDetailViewController.Dependency) -> MovieDetailViewController = { dependency in
            return .init(dependency: dependency)
        }
        
        return .init(
            mainCoordinator: .init(
                dependency: .init(
                    storage: storage,
                    mainNavigationController: mainNavigationController,
                    mainViewControllerFactory: mainViewControllerFactory,
                    movieListViewControllerFactory: movieListViewControllerFactory,
                    movieDetailViewControllerFactory: movieDetailViewControllerFactory
                )
            )
        )
    }
}

