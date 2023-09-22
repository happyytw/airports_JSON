//
//  Constants.swift
//  MySQLApp
//
//  Created by Taewon Yoon on 2023/09/07.
//

import Foundation

struct Constants {
    private static let baseUrlPath = "http://127.0.0.1:8080"
    
    struct Urls {
        static let register = URL(string: "\(baseUrlPath)/register")
        static let login = URL(string: "\(baseUrlPath)/login")
        static let chat = URL(string: "\(baseUrlPath)/chatByDistrict")
        static let message = URL(string: "\(baseUrlPath)/chat/message")
        static let makefriend = URL(string: "\(baseUrlPath)/friend")
        static let getfriend = URL(string: "\(baseUrlPath)/friend")
    }
}
