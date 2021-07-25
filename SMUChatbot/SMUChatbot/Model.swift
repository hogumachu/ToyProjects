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
        return Observable<String>.create { observer in
            let urlString = "http://127.0.0.1:8000/get_info/?data=\(text)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                observer.onNext("Invalid URL")
                return Disposables.create()
            }
            
            var request = URLRequest(url: url)
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { closureData, response, error in
                if error != nil {
                    print("Error in task")
                    observer.onNext("Error in task")
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Invalid Response in task")
                    observer.onNext("Invalid Response in task")
                    return
                }
                
                guard (200...299).contains(response.statusCode) else {
                    print("Invalid StatusCode in task: \(response.statusCode)")
                    observer.onNext("Invalid StatusCode in task: \(response.statusCode)")
                    return
                }
                
                guard let guardData = closureData else {
                    print("Invalid Data in task")
                    observer.onNext("Invalid Data in task")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let dataString = try decoder.decode(data.self, from: guardData)
                    DispatchQueue.global().async {
                        print("Data:", dataString.data)
                        DispatchQueue.global().async {
                            observer.onNext(dataString.data)
                        }
                    }

                } catch {
                    DispatchQueue.main.async {
                        observer.onNext("DecodingError in task")
                    }
                    return
                }
            }
            task.resume()
            
            return Disposables.create()
        }
        
    }
}

struct data: Codable {
    let data: String
}
