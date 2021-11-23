import Foundation

class MainViewModel: StorableViewModelType {
    struct Dependency {
        let coordinator: Coordinator
        let storage: MovieStorageType
    }
    
    let coordinator: Coordinator
    let storage: MovieStorageType
    var startLoading = {}
    var endLoading = {}
    private var loading = false
    
    
    init(dependency: Dependency) {
        self.coordinator = dependency.coordinator
        self.storage = dependency.storage
    }
    
    func next(score: String?) {
        if loading {
            return
        }
        loading = true
        startLoading()
        
        Repository.shared.execute(url: Repository.shared.generateURL(score: score ?? "0", page: 1)) { [weak self] (result: Result<MovieResponse, Error>) in
            switch result {
            case .success(let success):
                if let data = success.data {
                    DispatchQueue.main.async {
                        self?.storage.setData(data: data)
                        self?.endLoading()
                        self?.loading = false
                        self?.coordinator.movieList(score: score ?? "0") 
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
