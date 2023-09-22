//
//  Friend.swift
//  MySQLApp
//
//  Created by Taewon Yoon on 2023/09/20.
//

import Foundation

struct UserFriend: Codable {
    var id: UUID?
    var friend_id: String
    var user: User
}


/*
 @Field(key: "friend_id")
 var friend_id: String
 
 @Parent(key: "my_id")
 var user: User
 */
