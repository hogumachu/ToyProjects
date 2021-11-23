import Foundation

class MovieListViewModel: StorableViewModelType {
    struct Dependency {
        let coordinator: Coordinator
        let storage: MovieStorageType
        let score: String
    }
    
    let coordinator: Coordinator
    let storage: MovieStorageType
    let score: String
    var loading = false
    
    init(dependency: Dependency) {
        self.coordinator = dependency.coordinator
        self.storage = dependency.storage
        self.score = dependency.score
    }
    
    func detail(at index: Int) {
        let movie = storage.movie(at: index)
        coordinator.movieDetail(movie: movie)
    }
    
    func next() {
        if loading {
            return
        }
        
        loading = true
        
        Repository.shared.execute(url: Repository.shared.generateURL(score: score, page: storage.currentPage())) { [weak self] (result: Result<MovieResponse, Error>) in
            switch result {
            case .success(let success):
                if let movies = success.data?.movies {
                    DispatchQueue.main.async {
                        self?.storage.addMovies(movies: movies)
                    }
                } else {
                    print("Next Page, Empty Movies")
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            
            self?.loading = false
        }
    }
}
