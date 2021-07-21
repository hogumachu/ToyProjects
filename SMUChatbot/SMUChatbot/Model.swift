//
//  Model.swift
//  SMUChatbot
//
//  Created by 홍성준 on 2021/07/21.
//

import Foundation
import RxSwift

class Model {
    func responseDjango(sendText text: String) {
        let urlString = "http://127.0.0.1:8000/get_info/?data=\(text)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { closureData, response, error in
            if let error = error {
                fatalError("Error in task")
            }
            
            guard let response = response as? HTTPURLResponse else {
                fatalError("Invalid Response in task")
            }
            
            guard (200...299).contains(response.statusCode) else {
                fatalError("Invalid StatusCode in task: \(response.statusCode)")
            }
            
            guard let guardData = closureData else {
                fatalError("Invalid Data in task")
            }
            do {
                let decoder = JSONDecoder()
                let dataString = try decoder.decode(data.self, from: guardData)
                DispatchQueue.main.async {
                    print("Data:", dataString.data)
                }

            } catch {
                fatalError("DecodingError in task")
            }
        }
        task.resume()
    }
}

struct data: Codable {
    let data: String
}
