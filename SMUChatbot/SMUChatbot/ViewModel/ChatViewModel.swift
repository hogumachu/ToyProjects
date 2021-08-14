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
    
    func chatting(sendText text: String){
        messages.append(Message(text: text, isSender: true))
        messageRelay.accept(messages)
        
        loadingRelay.accept(true)
        
        let urlRequest = URLRequest(url: URL(string: "http://127.0.0.1:8000/get_info/?data=\(text)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        let data = URLSession.shared.rx.data(request: urlRequest)
        
        data.subscribe(onNext: { [unowned self] data in
            let text = decodeData(data: data)
            messages.append(Message(text: text, isSender: false))
            messageRelay.accept(messages)
            
            loadingRelay.accept(false)
            
            messages.append(Message(text: "", isSender: false))
            messageRelay.accept(messages)
        }).disposed(by: disposeBag)
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
    
    func keyboardWillShowNotiObservable() -> Observable<CGFloat> {
        return NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillShowNotification)
            .map { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0}
    }
    
    func keyboardWillHideNotiObservable() -> Observable<CGFloat> {
        return NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillHideNotification)
            .map { notification -> CGFloat in 0 }
    }
}
