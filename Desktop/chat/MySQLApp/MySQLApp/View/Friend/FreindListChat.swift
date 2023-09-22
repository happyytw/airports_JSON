//
//  FreindListChat.swift
//  MySQLApp
//
//  Created by Taewon Yoon on 2023/09/21.
//

import SwiftUI

struct FreindListChat: View {
    
    // MARK: - PROEPERTIES
    
    @State var friends: [UserFriend]
    @State var friendName: String = ""
    @State var toggleState: [UUID: Bool] = [:]
    
    // MARK: - BODY
    
    var body: some View {
        HStack {
            List {
                if !friends.isEmpty {
                    ForEach($friends, id: \.id) { friend in
                        HStack {
                            Text(friend.friend_id.wrappedValue)
                            Spacer()
                            Button {
                                print("\(friend.friend_id.wrappedValue)")
                                toggleState[friend.wrappedValue.id!] = !(toggleState[friend.wrappedValue.id!] ?? false)
                            } label: {
                                Image(systemName: toggleState[(friend.wrappedValue.id ?? UUID(uuidString: ""))!]! ? "checkmark.circle.fill" : "circle")
                            }
                        }
                        
                    }
                }
            }
            .onAppear {
                print("갯수\(friends.count)")
            }
        }
    }
}

struct FreindListChat_Previews: PreviewProvider {
    static var previews: some View {
        FreindListChat(friends: [UserFriend(friend_id: "2000ytw", user: User()), UserFriend(friend_id: "pcy000", user: User()),UserFriend(friend_id: "happyytw", user: User())])
    }
}
