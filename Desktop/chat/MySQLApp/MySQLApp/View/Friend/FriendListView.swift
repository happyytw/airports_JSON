//
//  FriendListView.swift
//  MySQLApp
//
//  Created by Taewon Yoon on 2023/09/20.
//

import SwiftUI

var globalFriends: [UserFriend] = []

struct FriendListView: View {
    
    // MARK: - PROPERTIES
    
    @AppStorage("userId") var userid = User(user_id: "", user_password: "").encode()!
//    @State var user: [User] = tmpUser
    @State var isPressed: Bool = false
    @State var addingUser: String = ""
    @State public var friends: [UserFriend] = [UserFriend(friend_id: "abc", user: User())]
    
    let model = FriendModel()
    
    
    // MARK: - FUNCTION
    
    // MARK: - BODY
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("친구추가") {
                    isPressed = true
                }
                .alert("Title", isPresented: $isPressed, actions: {
                    TextField("입력", text: $addingUser)
                        .textInputAutocapitalization(.never)
                    
                    Button("추가", action: {
                        print("추가")
                        Task { // User값을 받아야한다.
                            let user = User.decode(userData: userid)
                            if addingUser != user?.user_id {
                                let result = try await model.registerFriend(friend: UserFriend(friend_id: addingUser, user: User.decode(userData: userid)!))
                                if !result.error {
                                    print("친구 추가 화면 갱신")
                                    friends = result.friends
                                } else {
                                    
                                    print(result.reason)
                                }
                            } else {
                                print("본인은 추가할 수 없다")
                            }
                            
                            
                        }
                    })
                    Button("취소", action: { print("취소") })
                }, message: {
                    // Any view other than Text would be ignored
//                    TextField("TextField", text: $addingUser)
                })
            }
            
//            FreindListChat(friends: [UserFriend(friend_id: "asdf", user: User())])
            FriendListMain(friends: friends) // LIST
//            List {
//                ForEach(friends, id: \.id) { friend in
//                    Text(friend.friend_id)
//                }
//            }
        }
        .padding()
        .onAppear {
            Task {
                do {
                    print("값을 가져온다")
                    friends = try await model.getFriend(user: User.decode(userData: userid)!).friends
                    print("값을 가져왔는데")
                    print(friends.description)
                    globalFriends = friends
                } catch {
                    print("가져온 친구들을 추가하는데 오류")
                }
            }
        }
//        .onChange(of: $friends) { newValue in
//            print("값 변경")
//        }
        
    }
}

struct FriendListView_Previews: PreviewProvider {
    static var previews: some View {
        FriendListView()
            .previewLayout(.sizeThatFits)
    }
}
