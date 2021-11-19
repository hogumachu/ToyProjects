import Foundation

class MainViewModel: ViewModelType {
    var coordinator: Coordinator?
    var startLoading = {}
    var endLoading = {}
    private var loading = false
    
    func next(score: String?) {
        if loading {
            return
        }
        loading = true
        startLoading()
        
        Repository.shared.execute(url: Repository.shared.generateURL(score: score ?? "0", page: 1)) { [weak self] (result: Result<MovieResponse, Error>) in
            switch result {
            case .success(let success):
                if let movies = success.data?.movies {
                    DispatchQueue.main.async {
                        self?.endLoading()
                        self?.loading = false
                        self?.coordinator?.movieList(movies: movies, page: success.data?.page_number ?? 1, score: score ?? "0")
                    }
                } else {
                    self?.loading = false
                    self?.endLoading()
                }
            case .failure(let failure):
                self?.loading = false
                self?.endLoading()
                print(failure.localizedDescription)
            }
        }
    }
}
