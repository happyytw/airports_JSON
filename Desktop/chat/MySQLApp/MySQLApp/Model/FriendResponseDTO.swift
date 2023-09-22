//
//  FriendResponseDTO.swift
//  MySQLApp
//
//  Created by Taewon Yoon on 2023/09/20.
//

import Foundation


struct FriendResponseDTO: Codable {
    var error: Bool
    var reason: String?
    var friends: [UserFriend]
}
