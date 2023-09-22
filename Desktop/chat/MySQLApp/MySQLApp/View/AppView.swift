//
//  AppView.swift
//  MySQLApp
//
//  Created by Taewon Yoon on 2023/09/10.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
//            ContentView()
//                .tabItem {
//                    Image(systemName: "location.circle")
//                    Text("지도")
//                }
//            InquiryView()
//                .tabItem {
//                    Image(systemName: "message")
//                    Text("문의")
//                }
            
//            ChatListView()
//                .tabItem {
//                    Image(systemName: "message")
//                    Text("문의")
//                }
            FriendListView()
                .tabItem {
                    Image(systemName: "person")
                    Text("친구목록")
                }
            ChatListView()
                .tabItem {
                    Image(systemName: "message")
                    Text("문의")
                }
            
            NotificationView()
                .tabItem {
                    Image(systemName: "info.bubble")
                    Text("공지사항")
                }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}

/*
    
*/
