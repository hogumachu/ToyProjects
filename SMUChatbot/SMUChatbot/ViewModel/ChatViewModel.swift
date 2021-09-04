import Foundation
import RxSwift
import RxCocoa

struct Message {
    let text: String
    let isSender: Bool
}

class ChatViewModel {
    let disposeBag = DisposeBag()
    var messages: [Message] = []
    lazy var messageRelay = BehaviorRelay<[Message]>(value: messages)
    var loadingRelay = BehaviorRelay<Bool>(value: false)
    let baseUrl = "http://127.0.0.1:8000"
    
    func chatting(sendText text: String){
        messages.append(Message(text: text, isSender: true))
        messageRelay.accept(messages)
        
        loadingRelay.accept(true)
        
        let urlRequest = URLRequest(url: URL(string: baseUrl + "/get_info/?data=\(text)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        
        URLSession.shared.rx.data(request: urlRequest)
            .subscribe(onNext: { [unowned self] data in
                let text = decodeData(data: data)
                messages.append(Message(text: text, isSender: false))
                messageRelay.accept(messages)
                loadingRelay.accept(false)
            }, onError: { [unowned self] _ in
                messages.append(Message(text: "챗봇이 작동하지 않고 있습니다.", isSender: false))
                messageRelay.accept(messages)
                loadingRelay.accept(false)
            }
            ).disposed(by: disposeBag)
    }
    
    private func decodeData(data: Data) -> String {
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
