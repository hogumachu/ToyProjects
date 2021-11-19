import UIKit

class Coordinator {
    struct Dependency {
        let mainNavigationController: UINavigationController
        let mainViewControllerFactory: () -> MainViewController
        let movieListViewControllerFactory: ([Movie], Int, String) -> MovieListViewController
        let movieDetailViewControllerFactory: (Movie) -> MovieDetailViewController
    }
    
    init(dependency: Dependency) {
        self.mainNavigationController = dependency.mainNavigationController
        self.mainViewControllerFactory = dependency.mainViewControllerFactory
        self.movieListViewControllerFactory = dependency.movieListViewControllerFactory
        self.movieDetailViewControllerFactory = dependency.movieDetailViewControllerFactory
    }
    
    let mainNavigationController: UINavigationController
    let mainViewControllerFactory: () -> MainViewController
    let movieListViewControllerFactory: ([Movie], Int, String) -> MovieListViewController
    let movieDetailViewControllerFactory: (Movie) -> MovieDetailViewController
}

extension Coordinator {
    func start() {
        let mainViewController = mainViewControllerFactory()
        mainViewController.viewModel.coordinator = self
        
        mainNavigationController.setViewControllers([mainViewController], animated: false)
    }
    
    func movieList(movies: [Movie], page: Int, score: String) {
        let movieListViewController = movieListViewControllerFactory(movies, page, score)
        movieListViewController.viewModel.coordinator = self
        
        mainNavigationController.pushViewController(movieListViewController, animated: true)
    }
    
    func movieDetail(movie: Movie) {
        let movieDetailViewController = movieDetailViewControllerFactory(movie)
        movieDetailViewController.viewModel.coordinator = self
        
        mainNavigationController.pushViewController(movieDetailViewController, animated: true)
    }
}
