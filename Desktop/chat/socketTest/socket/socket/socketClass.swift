//
//  socketClass.swift
//  socket
//
//  Created by Taewon Yoon on 2023/09/18.
//

import Foundation
import SwiftUI

var num = ""

class socketClass {
    var webSocketTask: URLSessionWebSocketTask!
    @AppStorage("userId") var userid: String = ""

    func connect() {
        let urlSession = URLSession(configuration: .default)
        webSocketTask = urlSession.webSocketTask(with: URL(string: "ws://127.0.0.1:8080/toki")!)
        webSocketTask.resume()
    }
    
    func sendMessage(name: String, message: String) { // username이 같으면 작동하지 않는다
        let message = URLSessionWebSocketTask.Message.string("""
        {"username":"\(name)", "message": "\(message)!"}
        """)

        webSocketTask.send(message) { error in
            if let error = error {
                print("websocket couldn't send message: \(error.localizedDescription)")
            }
        }
    }

    func receiveMessage(completion: @escaping (String?) -> Void) {
        print("재귀함수")
        var tmp: String?
        
        webSocketTask.receive { result in
            switch result {
            case .failure(let error):
                print("Something went wrong: \(error.localizedDescription)")
                completion(nil)
            case .success(let message):
                switch message {
                case .data(let data):
                    print("Data: \(data)")
                    // 처리할 데이터가 있다면 여기에서 처리하세요.
                case .string(let messages):
                    print("Message: \(messages)")
                    tmp = messages.description
                default:
                    print("unknown case")
                }
                
                print("가져온 값은:\(tmp ?? "No Value")")
                completion(tmp)
            }
            self.receiveMessage { i in }
        }
    }

}
