import Foundation
import RxSwift

class ChatViewModel {
    func responseDjango(sendText text: String) -> Observable<String> {
        print(text)
        let urlRequest = URLRequest(url: URL(string: "http://127.0.0.1:8000/get_info/?data=\(text)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        
        let response = Observable.just(urlRequest)
            .flatMap(URLSession.shared.rx.data(request:))
            .map { self.decodeData(data: $0) }
        
        return response
        
    }
    
    func decodeData(data: Data) -> String {
        do {
            let decoder = JSONDecoder()
            let dataString = try decoder.decode(content.self, from: data)
            return dataString.content
        } catch {
            print(error)
            return "decodeData Error"
        }
        
    }
    }
