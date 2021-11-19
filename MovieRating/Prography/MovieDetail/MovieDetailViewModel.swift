import Foundation

class MovieDetailViewModel: ViewModelType {
    struct Dependency {
        let movie: Movie
    }
    var coordinator: Coordinator?
    private let movie: Movie
    
    init(dependency: Dependency) {
        self.movie = dependency.movie
    }
    
    func item() -> Movie {
        return movie
    }
}
