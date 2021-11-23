import RxSwift

class MovieStorage: MovieStorageType {
    private var dataClass: DataClass = .Empty
    private lazy var moviesObservable = BehaviorSubject<[Movie]>(value: dataClass.movies ?? [])
    
    func setData(data: DataClass) {
        self.dataClass = data
        moviesObservable.onNext(data.movies ?? [])
    }
    
    func movieList() -> Observable<[Movie]> {
        return moviesObservable
    }
    
    func movie(at index: Int) -> Movie {
        return dataClass.movies?[index] ?? .Empty
    }
    
    func currentPage() -> Int {
        if let currentPage = dataClass.page_number {
            dataClass.page_number = currentPage + 1
            
            return dataClass.page_number!
        }
        
        return 1
    }
    
    func addMovies(movies: [Movie]) {
        dataClass.movies?.append(contentsOf: movies)
        moviesObservable.onNext(dataClass.movies ?? [])
    }
}
