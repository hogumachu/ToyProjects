import Foundation
import UIKit

class MovieListViewModel: ViewModelType {
    struct Dependency {
        let movies: [Movie]
        let page: Int
        let score: String
    }
    var coordinator: Coordinator?
    private var movies: [Movie]
    private var page: Int
    private let score: String
    
    var startLoading = {}
    var endLoading = {}
    private var loading = false
    
    init(dependency: Dependency) {
        self.movies = dependency.movies
        self.page = dependency.page
        self.score = dependency.score
    }
    
    func movie(at index: Int) -> Movie {
        return movies[index]
    }
    
    func movieCount() -> Int {
        return movies.count
    }
    
    func detail(movie: Movie) {
        coordinator?.movieDetail(movie: movie)
    }
    
    func next() {
        if loading {
            return
        }
        print(page)
        loading = true
        page += 1
        
        let url = "https://yts.mx/api/v2/list_movies.json?limit=20&minimum_rating=\(score)&sort_by=rating&order_by=asc&page=\(page)"
        startLoading()
        
        Repository.shared.execute(url: url) { [weak self] (result: Result<MovieResponse, Error>) in
            switch result {
            case .success(let success):
                if let movies = success.data?.movies {
                    DispatchQueue.main.async {
                        print("Success")
                        self?.loading = false
                        self?.movies.append(contentsOf: movies)
                        self?.endLoading()
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.loading = false
                        self?.endLoading()
                    }
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    self?.loading = false
                    self?.endLoading()
                }
                print(failure.localizedDescription)
            }
        }
    }
}
