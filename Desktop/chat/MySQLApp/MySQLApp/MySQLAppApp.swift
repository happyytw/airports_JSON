//
//  MySQLAppApp.swift
//  MySQLApp
//
//  Created by Taewon Yoon on 2023/09/07.
//

import SwiftUI

@main
struct MySQLAppApp: App {
    
//    @StateObject private var model = DataModel()
    var body: some Scene {
        WindowGroup {
//            LoginView()
            LoginView()
                .environmentObject(LoginModel())
        }
    }
}
