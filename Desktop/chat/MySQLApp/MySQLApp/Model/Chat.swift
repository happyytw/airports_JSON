//
//  Chat.swift
//  MySQLApp
//
//  Created by Taewon Yoon on 2023/09/15.
//

import Foundation
import SwiftUI

//@AppStorage("userId") var userid: String = ""
struct Chat: Codable, Hashable {
    static func == (lhs: Chat, rhs: Chat) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        
    }
    
    var id: UUID?
    var from_id: String?
    var to_id: String?
    var district: Int?
    var last_chat: String?
    var createdAt: String?
    
    func isFromCurrentUser() -> Bool {
        return true
//        return currentUserId == userid ? true : false
    }
    
//    var messages: [Message]?
}

struct Message: Codable, Hashable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        
    }
    
    var id: UUID?
    var message: String
    var sender: String
    var createdAt: Double?
    var chat: Chat

    func isFromCurrentUser(currentUser: String) -> Bool {
        return sender == currentUser
//        return currentUserId == userid ? true : false
    }
}

struct GetChatStruct: Codable {
    var id: UUID
}
