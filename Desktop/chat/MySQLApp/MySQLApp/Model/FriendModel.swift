//
//  ChatModel.swift
//  MySQLApp
//
//  Created by Taewon Yoon on 2023/09/20.
//

import Foundation

class FriendModel {
    
    let httpClient = HTTPClient()
    
    func registerFriend(friend: UserFriend) async throws -> FriendResponseDTO {
        let resource = try Resource(url: Constants.Urls.makefriend!, method: .post(JSONEncoder().encode(friend)) ,modelType: FriendResponseDTO.self)
        print(try JSONEncoder().encode(friend).description)
        let FriendResponseDTO = try await httpClient.load(resource)
        return FriendResponseDTO
    }
    
//    func getFriend(user: User) async throws -> FriendResponseDTO {
//        print(try JSONEncoder().encode(user))
//        print(user)
//        let resource = Resource(url: Constants.Urls.getfriend!, method: .post(try JSONEncoder().encode(user)), modelType: FriendResponseDTO.self)
//        let FriendResponseDTO = try await httpClient.load(resource)
//        return FriendResponseDTO
//    }
    func getFriend(user: User) async throws -> FriendResponseDTO {
        let query = URLQueryItem(name: "userid", value: user.id?.uuidString)
        let resource = Resource(url: Constants.Urls.getfriend!, method: .get([query]), modelType: FriendResponseDTO.self)
        let FriendResponseDTO = try await httpClient.load(resource)
        return FriendResponseDTO
    }
    
}

//        @Field(key: "friend_id")
//        var friend_id: String
//
//        @Parent(key: "my_id")
//        var user: User
