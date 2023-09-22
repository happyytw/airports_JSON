//
//  LoginResponseDTO.swift
//  MySQLApp
//
//  Created by Taewon Yoon on 2023/09/10.
//

import Foundation

struct LoginResponseDTO: Codable {
    var error: Bool
    var reason: String?
    var user: User
}
