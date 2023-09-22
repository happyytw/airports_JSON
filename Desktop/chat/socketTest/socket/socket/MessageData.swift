//
//  MessageData.swift
//  MySQLApp
//
//  Created by Taewon Yoon on 2023/09/10.
//

import Foundation



////var tmp: [String] = ["A","B","C","D"]
//
//var tmpChat: [Chat] =
//[
//    Chat(id: UUID(uuidString: "26B7B4A5-87FA-441D-831B-A5B08D65CDF1")
//         ,from_id: "이성희", to_id: "박찬영", district: 3, last_chat: "없다",createdAt: "districtT17:05:39Z")
//]
//
//var tmp2Chat: [GetChatStruct] =
//[
//    GetChatStruct(id: UUID(uuidString: "26B7B4A5-87FA-441D-831B-A5B08D65CDF1")!),
//    GetChatStruct(id: UUID(uuidString: "26B7B4A5-87FA-441D-831B-A5B08D65CDF1")!),
//    GetChatStruct(id: UUID(uuidString: "26B7B4A5-87FA-441D-831B-A5B08D65CDF1")!),
//    GetChatStruct(id: UUID(uuidString: "26B7B4A5-87FA-441D-831B-A5B08D65CDF1")!),
//    GetChatStruct(id: UUID(uuidString: "26B7B4A5-87FA-441D-831B-A5B08D65CDF1")!)
//]
//
//var messages : [Message] =
//[
//    Message(message: "아오 또 너야?", sender: "20dl", createdAt: "Date()", chat: tmpChat[0]),
//    Message(message: "아오 또 너야?", sender: "20dl", createdAt: "Date()", chat: tmpChat[0]),
//
//    Message(message: "아오 또 너야?", sender: "20dl", createdAt: "Date()", chat: tmpChat[0]),
//
////    Message(message: "아오 또 너야?", sender: "20dl", createdAt: Date(), chat: tmp2Chat[0]),
////    Message(message: "아오 또 너야?", sender: "20dl", createdAt: Date(), chat: tmp2Chat[0]),
////    Message(message: "아오 또 너야?", sender: "20dl", createdAt: Date(), chat: tmp2Chat[0]),
//
//]


struct User: Codable {
    let username: String
    let message: String
}

struct Message: Codable, Hashable, Identifiable {
    var id: UUID?
    
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.username == rhs.username
    }
    
    func hash(into hasher: inout Hasher) {
        
    }
    var username: String
    var message: String
}
