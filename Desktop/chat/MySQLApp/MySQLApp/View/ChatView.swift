//
//  ChatView.swift
//  MySQLApp
//
//  Created by Taewon Yoon on 2023/09/10.
//

import SwiftUI
import NIOCore



struct ChatView: View {
    
    // MARK: - PROPERTIES
    @State private var textfield: String = ""
    @State private var district: String = ""
    @State private var messages: [Message] = []
    @State private var webSocketTask: URLSessionWebSocketTask!

    @AppStorage("userId") var userid: String = ""

    var chat: Chat
    var model = ChatModel()

    // MARK: - FUNCTION
    
    func connect() {
        let urlSession = URLSession(configuration: .default)
        webSocketTask = urlSession.webSocketTask(with: URL(string: "ws://127.0.0.1:8080/toki")!)
        webSocketTask.resume()
    }
    
    func sendMessage(first: Bool) { // username이 같으면 작동하지 않는다
        if first == false {
            print("버튼 눌렀을때 값 보내는거 시도")
//            let data = Message(message: textfield, sender: userid, createdAt: Date().ISO8601Format(), chat: chat)
            let data = Message(message: textfield, sender: userid, chat: chat)
            do {
                let message = try URLSessionWebSocketTask.Message.data(JSONEncoder().encode(data))
                webSocketTask.send(message) { error in
                    if let error = error {
                        print("websocket couldn't send message: \(error.localizedDescription)")
                    }
                }
                
            } catch {
                print("인코딩 에러")
            }
        } else {
            print("첫번째때 값 보내는거 시도")
            print(self.userid, self.chat.id!)
            let message = URLSessionWebSocketTask.Message.string("""
                                                                 \(self.userid):\(self.chat.id!)
                                                                 """)
            webSocketTask.send(message) { error in
                print("빈 값, 초기 설정을 하기 위해서 전송하는데 에러:\(error?.localizedDescription)")
            }
            
            print("첫번째값 전송 성공")
        }


    }
    
    func receiveMessage() {
        print("WebSocket으로 받은 데이터 처리 시작")
        
        webSocketTask.receive { result in
            switch result {
            case .failure(let error):
                print("오류 발생: \(error.localizedDescription)")
            case .success(let message):
                switch message {
                case .data(let data):
                    print("데이터 수신")
                    
                    let stringMessage = String(data: data, encoding: .utf8)
                    print(stringMessage)
//                    if let jsonData = stringMessage?.data(using: .utf8) {
//                        do {
//                            let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [[String: Any]]
//                            print(jsonArray)
//
//                        } catch {
//                            print("JSON 변환 오류: \(error)")
//                        }
//                    }
                    
                    
                    
                    do {
                        let result = try JSONDecoder().decode([Message].self, from: data)
                        print(result.description)
                        messages = result
                    } catch {
                        print("디코딩 실패: \(error)")
                    }
                    
                    
                    
                    

                case .string(let messageText):
                    print("문자열 메시지: \(messageText)")
                    // 문자열로 받은 값을 JSON으로 치환
                default:
                    print("알 수 없는 형태의 데이터")
                }
            }
            
            // 계속해서 WebSocket 메시지 수신 대기
            self.receiveMessage()
        }
    }

    
    // MARK: - BODY
    
    var body: some View {
//        NavigationView {
            VStack {
                ScrollViewReader { ScrollViewProxy in
                    ScrollView {
                        VStack(spacing: 10) {
//                            Text(chat.from_id ?? "미지정유저")
                            ForEach(messages, id: \.self) { message in
                                MessageView(message: message, chat: chat)
                            }
                            
                        }
                    }
                    .onAppear {
                        if !messages.isEmpty {
                            ScrollViewProxy.scrollTo(messages[messages.endIndex - 1])
                        }
                    }
                    .onChange(of: messages) { newValue in
                        ScrollViewProxy.scrollTo(messages[messages.endIndex - 1])
                    }
                }

                
                HStack {
                    TextField("메시지를 입력하세요", text: $textfield)
                        .padding(.all, 8)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                    Button {
                        print("버튼 눌렸다")
                        // MARK: - 메시지 전송하는 부분
                        self.sendMessage(first: false)
                        
                    } label: {
                        Image(systemName: "paperplane")
                    }

                }
                .padding(.horizontal, 20)

            }
            .navigationTitle((chat.from_id == userid ? chat.to_id : chat.from_id)!)
            .onAppear {
                // 소켓 연결
                self.connect()
                self.sendMessage(first: true)
                self.receiveMessage()
                // 메시지 내용 가져오는 곳
//                Task {
//                    messages = try await model.getMessages(chatId: chat.id!)
//                    print(messages.count)
//                }
            }

    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(chat: tmpChat[0])
    }
}
