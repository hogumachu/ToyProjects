import RxSwift
import RxCocoa

class MainViewModel {
    let disposeBag = DisposeBag()
    var searchRelay = BehaviorRelay<[Item]>(value: [])
    
    func searchRequest(_ text: String) {
        let urlString = "https://openapi.naver.com/v1/search/local.json?query=\(text)&display=10&start=1&sort=random".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: urlString)!
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        urlRequest.setValue(APiRepository.clientId, forHTTPHeaderField: "X-Naver-Client-Id")
        urlRequest.setValue(APiRepository.clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let data = URLSession.shared.rx.data(request: urlRequest)
        data.subscribe(onNext: { [unowned self] data in
            let content = decodeData(data: data)
            searchRelay.accept(content)
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


