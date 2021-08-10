import Foundation
import RxSwift
import RxCocoa

class ChatViewModel {
    let disposeBag = DisposeBag()
    var messages: [String] = []
    lazy var messageRelay = BehaviorRelay<[String]>(value: messages)
    
    func chatting(sendText text: String){
        messages.append(text)
        messageRelay.accept(messages)
        let urlRequest = URLRequest(url: URL(string: "http://127.0.0.1:8000/get_info/?data=\(text)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        let data = URLSession.shared.rx.data(request: urlRequest)
        
        data.subscribe(onNext: { [unowned self] data in
            let text = decodeData(data: data)
            messages.append(text)
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
