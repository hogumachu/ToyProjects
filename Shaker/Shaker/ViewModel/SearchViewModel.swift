import RxSwift
import RxCocoa

class SearchViewModel {
    let disposeBag = DisposeBag()
    var searchRelay = BehaviorRelay<[Item]>(value: [])
    var loadingRelay = BehaviorRelay<Bool>(value: false)
    
    func searchRequest(_ text: String) {
        loadingRelay.accept(true)
        let urlString = "https://openapi.naver.com/v1/search/local.json?query=\(text)&display=5&start=1&sort=comment".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: urlString)!
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        urlRequest.setValue(APIRepository.searchClientId, forHTTPHeaderField: "X-Naver-Client-Id")
        urlRequest.setValue(APIRepository.searchClientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let data = URLSession.shared.rx.data(request: urlRequest)
        data.subscribe(onNext: { [unowned self] data in
            let content = decodeData(data: data)
            searchRelay.accept(content)
            loadingRelay.accept(false)
        }).disposed(by: disposeBag)
    }
    
    private func decodeData(data: Data) -> [Item] {
        do {
            let decoder = JSONDecoder()
            let content = try decoder.decode(Content.self, from: data)
            return content.items
        } catch {
            print(error)
            return []
        }
    }
}
