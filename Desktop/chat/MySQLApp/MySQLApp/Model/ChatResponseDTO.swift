//
//  ChatResponseDTO.swift
//  MySQLApp
//
//  Created by Taewon Yoon on 2023/09/15.
//

import Foundation

struct ChatResponseDTO: Codable {
    var error: Bool
    var reason: String?
}
