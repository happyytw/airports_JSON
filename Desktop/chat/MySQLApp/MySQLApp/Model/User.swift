//
//  User.swift
//  MySQLApp
//
//  Created by Taewon Yoon on 2023/09/20.
//

import Foundation

struct User: Codable {
    var id: UUID?
    var user_id: String?
    var user_password: String?
    
    func encode() -> Data? {
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(self) {
            return encoded
        } else {
            return nil
        }
    }
    
    // AppStorage에서 Data값을 가져오면, User 구조체로 다시 변환해 화면에 뿌려줄 수 있음.
     static func decode(userData: Data) -> User? {
         let decoder = JSONDecoder()
         
         if let user = try? decoder.decode(User.self, from: userData) {
             return user
         } else {
             return nil
         }
     }
    
}


var tmpUsers: [User] = [User(user_id: "pcy", user_password: ""), User(user_id: "pmg", user_password: "")]

var tmpUser: User = User(user_id: "taewon", user_password: "")
