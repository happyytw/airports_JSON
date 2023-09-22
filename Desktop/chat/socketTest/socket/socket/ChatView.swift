//
//  ChatView.swift
//  socket
//
//  Created by Taewon Yoon on 2023/09/18.
//

import SwiftUI





struct ChatView: View {
    
    // MARK: - PROPERTIES
    @State private var textfield: String = ""
    @State private var district: String = ""
    @State private var messages: Message = Message(username: "taewon", message: "nonono")
    @State private var ttt: String = ""
    @State private var webSocketTask: URLSessionWebSocketTask!

    
    @AppStorage("userId") var userid: String = ""
    
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
                    self.ttt = messagii
                default:
                    print("unknown case")
                }
            }
            self.receiveMessage()
        }
    }
    
    // MARK: - BODY
    
    var body: some View {
//        NavigationView {
            VStack {
                Text(ttt)
//                ForEach(messages, id: \.id) { message in
//                    MessageView(message: message)
//                }
//                .onChange(of: ttt) { newValue in
//                    print("새로운값: \(newValue)")
//                    if let index = messages.firstIndex(where: { $0.username == userid }) {
//                        messages[index].message = newValue
//                    }
//                }

                
                HStack {
                    TextField("메시지를 입력하세요", text: $textfield)
                        .padding(.all, 8)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                    Button {
                        print("버튼 눌렸다")
                        // MARK: - 메시지 전송하는 부분
                        self.sendMessage(name: userid, message: textfield)
                        textfield = ""
                        
                    } label: {
                        Image(systemName: "paperplane")
                    }

                }
                .padding(.horizontal, 20)

            }
            .onAppear {
                // 소켓 연결
                self.connect()
                self.sendMessage(name: userid, message: "")
                self.receiveMessage()
                // 메시지 내용 가져오는 곳
//                Task {
//                    print(messages.count)
//                }
            }
            .onDisappear {
            }

            
//        }

    }
    
//    func receiveMessages() {
//        SOCKET.receiveMessage { value in
//            if let value = value {
//                print("새롭게 가져옴")
//                let newMessage = Message(username: userid, message: value)
//                messages[0] = newMessage
//            }
//        }
//    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
