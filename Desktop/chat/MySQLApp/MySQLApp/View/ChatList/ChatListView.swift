//
//  ChatList.swift
//  MySQLApp
//
//  Created by Taewon Yoon on 2023/09/11.
//

import SwiftUI
import SocketIO




struct ChatListView: View { // 관리자 전용 체팅 목록
    // MARK: - PROPERTIES
    
    private var tmp: [Int] = [1,2,3,4,5]
    @AppStorage("district") var district: Int = 1
    @State private var chats: [Chat] = []
    @State private var isPresented = false
    @Environment(\.dismiss) var dismiss
    
    
    var model = ChatModel()
        
    // MARK: - 소켓 설정

    
    // MARK: - FUNCTION
    
    
    
//    func getChats() async {
//        do {
//            let tmp = try await model.getChat(district: district)
//            chats.removeAll()
//            chats = tmp
//        } catch {
//            print(error)
//        }
//    }
    
    // MARK: - BODY
    
    var body: some View {

        NavigationView {
            List {
                ForEach($chats, id: \.id) { chat in
                    NavigationLink(destination: ChatView(chat: chat.wrappedValue)) {
                        HStack {
                            VStack {
                                HStack {
                                    Text(chat.from_id.wrappedValue! + ":")
                                    Spacer()
                                }
                                .padding(.bottom, 3)
                                HStack {
                                    Text(chat.last_chat.wrappedValue!)
                                    Spacer()
                                }
                            }
                        }
                    }
                } // FOREACH
            } //: LIST
            .navigationTitle("체팅목록")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem {
                    addButton
                }
            })
            
        } // NAVIGATIONVIEW
        
        .onAppear {
            // 데이터 가져오는 것들
//            Task {
//                print("viewdidload됐다")
//                await getChats()
//                self.chats =  try await model.getChat(district: district)
////                print("가져온 chat의 마지막 값:\(chats[0].last_chat)")
//            }
        }
        .onChange(of: district) { newValue in
//            Task {
//                print("viewdidload되었음")
//                await getChats()
//                self.chats =  try await model.getChat(district: district)
//            }
        }
            
    }
    
    private var addButton: some View {
        Button {
            print("체팅방 추가 버튼 클릭")
            self.isPresented.toggle()
        } label: {
            Text("추가")
        }
        .fullScreenCover(isPresented: $isPresented) {
            VStack {
                Button {
                    print("")
                    dismiss()
                } label: {
                    Text("뒤로가기")
                        .padding()
                    Spacer()
                }
                
                // 친구 목록 가져오기
                FreindListChat(friends: globalFriends)
            }
        }
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
    }
}
