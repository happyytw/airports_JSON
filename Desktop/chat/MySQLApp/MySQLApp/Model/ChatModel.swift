//
//  ChatModel.swift
//  MySQLApp
//
//  Created by Taewon Yoon on 2023/09/21.
//

import Foundation


class ChatModel {
    
    let httpClient = HTTPClient()
    
    // MARK: - 구역별 채팅방 가져오는 부분
    func getChat(district: Int) async throws -> [Chat] {
        let data = URLQueryItem(name: "district", value: district.formatted())
        let resource = Resource(url: Constants.Urls.chat!, method: .get([data]), modelType: [Chat].self)
        let Chats = try await httpClient.load(resource)
        print("채팅가져온값...\(Chats.first)")
        return Chats
    }
    
    
    // MARK: - 메시지 가져오는 부분
    func getMessages(chatId: UUID) async throws -> [Message] {
        let data = URLQueryItem(name: "chatid", value: chatId.uuidString)
        let resource = Resource(url: Constants.Urls.message!, method: .get([data]), modelType: [Message].self)
        let messages = try await httpClient.load(resource)
        return messages
    }
    
    
    // MARK: - 메시지 전송하는 부분
    func sendMessages(message: Message) async throws -> [Message] { // 메시지 전송하는부분
        //        print("인코딩 부분")
        let resource = try Resource(url: Constants.Urls.message!, method: .post(JSONEncoder().encode(message)),modelType: [Message].self)
        //        print("인코딩 성공")
        let messages = try await httpClient.load(resource)
        //        print("전송 성공")
        return messages
    }
    
}
