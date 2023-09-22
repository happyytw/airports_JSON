//
//  ContentView.swift
//  socket
//
//  Created by Taewon Yoon on 2023/09/18.
//

import SwiftUI

struct ContentView: View {
    @State private var value: String = ""
    @State private var user_id: String = ""
    @State private var user_passowrd: String = ""
    @State private var isPressed = false
    @AppStorage("userId") var userid: String = ""
    @State private var webSocketTask: URLSessionWebSocketTask!

    // MARK: - FUNCTION
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
    
    func receiveMessage() {
        print("파이프에 있는값 가져오기")
        webSocketTask.receive { result in
            switch result {
            case .failure(let error):
                print("Something went wrong: \(error.localizedDescription)")
            case .success(let message):
                switch message {
                case .data(let data):
                    print("Data: \(data)")
                    // 처리할 데이터가 있다면 여기에서 처리하세요.
                case .string(let messagii):
                    print("Message: \(messagii)")
                default:
                    print("unknown case")
                }
            }
            self.receiveMessage()
        }
    }
    
    // MARK: - BODY

    var body: some View {
        
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    TextField(text: $user_id, label: {
                        Text("아이디를 입력")
                    })
                    .padding()
                    Spacer()
                }
                
                    Button(action: {
                        print("로그인")
                        userid = user_id
                        isPressed.toggle()
                        connect()
                        sendMessage(name: userid, message: "")
                    }, label: {
                        Text("로그인")
                            .font(.system(size: 20))
                            .fontWeight(.light)
                            .foregroundColor(.accentColor)
                    })
                    .fullScreenCover(isPresented: $isPressed) {
                        ChatView()
                    }
            }
        }
        
        

            
//            Button {
//                print("버튼 눌렸다")
//                tmp.sendMessage()
////                connect()
//            } label: {
//                Text("Connect")
//            }
//            .padding()
//            Button {
//                print("받는 버튼")
//                tmp.receiveMessage()
//                value = num
////                receiveMessage()
//            } label: {
//                Text("받는버튼")
//            }


        }
//        .padding()
//        .onAppear {
//            print("연결")
//            tmp.connect()
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



/*
 
 //        webSocketTask.receive { result in
 //            switch result {
 //            case .success(let message):
 //                switch message {
 //                case .data(let data):
 //                    value = data.description
 //                    print("Got data: \(data)")
 ////                    webSocketTask.send(message) { error in
 ////                        if let error = error { print("websocket couldn't send message: \(error.localizedDescription)")}
 ////                    }
 //                case .string(let message):
 //                    value = message
 //                    print("Got string: \(message)")
 //
 ////                    webSocketTask.send(URLSessionWebSocketTask.Message.string("")) { error in
 ////                        print(error)
 ////                    }
 //                default:
 //                    break
 //                }
 //            case .failure(let error):
 //                print("Receive eror: \(error)")
 //            }
 //
 //        }
         
 
 */
