import RxSwift

protocol MovieStorageType {
    func setData(data: DataClass)
    func movieList() -> Observable<[Movie]>
    func movie(at: Int) -> Movie
    func currentPage() -> Int
    func addMovies(movies: [Movie])
}
