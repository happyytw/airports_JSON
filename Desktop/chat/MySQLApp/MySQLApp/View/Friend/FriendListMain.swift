//
//  FriendList.swift
//  MySQLApp
//
//  Created by Taewon Yoon on 2023/09/20.
//

import SwiftUI

struct FriendListMain: View {
    
    // MARK: - PROPERTIES
    var friends: [UserFriend]
    
    // MARK: - FUNCTION
    
    
    // MARK: - BODY
    
    
    var body: some View {
        HStack {
            List {
                ForEach(friends, id: \.id) { friend in
                    Text(friend.friend_id)
                }
            }
        }
    }
}

struct FriendListMain_Previews: PreviewProvider {
    static var previews: some View {
        FriendListMain(friends: [UserFriend(friend_id: "", user: User())])
            .previewLayout(.sizeThatFits)
    }
}

//let tmpfriend = UserFriend(friend_id: "", user: User())
