import Foundation

class MainViewModel: ViewModelType {
    var coordinator: Coordinator?
    var startLoading = {}
    var endLoading = {}
    
    func next(score: String?) {
        startLoading()
        
        Repository.shared.execute(url: Repository.shared.generateURL(score: score ?? "0", page: 1)) { [weak self] (result: Result<MovieResponse, Error>) in
            switch result {
            case .success(let success):
                if let movies = success.data?.movies {
                    DispatchQueue.main.async {
                        self?.endLoading()
                        self?.coordinator?.movieList(movies: movies, page: success.data?.page_number ?? 1, score: score ?? "0")
                    }
                } else {
                    self?.endLoading()
                }
            case .failure(let failure):
                self?.endLoading()
                print(failure.localizedDescription)
            }
        }
    }
}
