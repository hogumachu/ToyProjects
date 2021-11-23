import UIKit

class Coordinator {
    struct Dependency {
        let storage: MovieStorageType
        let mainNavigationController: UINavigationController
        let mainViewControllerFactory: (MainViewController.Dependency) -> MainViewController
        let movieListViewControllerFactory: (MovieListViewController.Dependency) -> MovieListViewController
        let movieDetailViewControllerFactory: (MovieDetailViewController.Dependency) -> MovieDetailViewController
    }
    
    init(dependency: Dependency) {
        self.storage = dependency.storage
        self.mainNavigationController = dependency.mainNavigationController
        self.mainViewControllerFactory = dependency.mainViewControllerFactory
        self.movieListViewControllerFactory = dependency.movieListViewControllerFactory
        self.movieDetailViewControllerFactory = dependency.movieDetailViewControllerFactory
    }
    
    let storage: MovieStorageType
    let mainNavigationController: UINavigationController
    let mainViewControllerFactory: (MainViewController.Dependency) -> MainViewController
    let movieListViewControllerFactory: (MovieListViewController.Dependency) -> MovieListViewController
    let movieDetailViewControllerFactory: (MovieDetailViewController.Dependency) -> MovieDetailViewController
}

extension Coordinator {
    func start() {
        let mainViewController = mainViewControllerFactory(.init(viewModel: .init(dependency: .init(coordinator: self, storage: storage))))
        
        mainNavigationController.setViewControllers([mainViewController], animated: false)
    }
    
    func movieList(score: String) {
        let movieListViewController = movieListViewControllerFactory(.init(viewModel: .init(dependency: .init(coordinator: self, storage: storage, score: score))))
        
        mainNavigationController.pushViewController(movieListViewController, animated: true)
    }
    
    func movieDetail(movie: Movie) {
        let movieDetailViewController = movieDetailViewControllerFactory(.init(viewModel: .init(dependency: .init(coordinator: self, movie: movie))))
        
        mainNavigationController.pushViewController(movieDetailViewController, animated: true)
    }
}
