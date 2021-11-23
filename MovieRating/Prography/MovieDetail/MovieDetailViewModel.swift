import Foundation

class MovieDetailViewModel: ViewModelType {
    struct Dependency {
        let coordinator: Coordinator
        let movie: Movie
    }
    let coordinator: Coordinator
    private let movie: Movie
    
    init(dependency: Dependency) {
        self.coordinator = dependency.coordinator
        self.movie = dependency.movie
    }
    
    func item() -> Movie {
        return movie
    }
}
