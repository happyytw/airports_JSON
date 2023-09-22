//
//  RegisterResponseDTO.swift
//  MySQLApp
//
//  Created by Taewon Yoon on 2023/09/07.
//

import Foundation

struct RegisterResponseDTO: Codable {
    var error: Bool
    var reason: String?
}
