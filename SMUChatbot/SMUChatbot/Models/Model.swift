//
//  Model.swift
//  SMUChatbot
//
//  Created by 홍성준 on 2021/07/21.
//

import Foundation
import RxSwift

class Model {
    func responseDjango(sendText text: String) -> Observable<String> {
        let urlRequest = URLRequest(url: URL(string: "http://127.0.0.1:8000/get_info/?data=\(text)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        
        let response = Observable.just(urlRequest)
            .flatMap(URLSession.shared.rx.data(request:))
            .map { self.decodeData(djangoData: $0) }
        
        return response
        
    }
    
    func decodeData(djangoData: Data) -> String {
        do {
            let decoder = JSONDecoder()
            let dataString = try decoder.decode(data.self, from: djangoData)
            return dataString.data
        } catch {
            print(error)
            return "decodeData Error"
        }
        
    }
}

struct data: Codable {
    let data: String
}
