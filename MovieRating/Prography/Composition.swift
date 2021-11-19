import UIKit

struct AppDependency {
    let mainCoordinator: Coordinator
}

extension AppDependency {
    static func resolve() -> AppDependency {
        let mainNavigationController = UINavigationController()
        let mainViewControllerFactory: () -> MainViewController = {
            return .init(dependency: .init(viewModel: .init()))
        }
        
        let movieListViewControllerFactory: ([Movie], Int, String) -> MovieListViewController = { movies, page, score in
            return .init(dependency: .init(viewModel: .init(dependency: .init(movies: movies, page: page, score: score))))
        }
        
        let movieDetailViewControllerFactory: (Movie) -> MovieDetailViewController = { movie in
            return .init(dependency: .init(viewModel: .init(dependency: .init(movie: movie))))
        }
        
        return .init(
            mainCoordinator: .init(
                dependency: .init(
                    mainNavigationController: mainNavigationController,
                    mainViewControllerFactory: mainViewControllerFactory,
                    movieListViewControllerFactory: movieListViewControllerFactory,
                    movieDetailViewControllerFactory: movieDetailViewControllerFactory
                )
            )
        )
    }
}

