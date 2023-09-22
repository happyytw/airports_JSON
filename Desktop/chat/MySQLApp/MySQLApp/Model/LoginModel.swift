//
//  DataModel.swift
//  MySQLApp
//
//  Created by Taewon Yoon on 2023/09/07.
//

import Foundation
import SwiftUI

class LoginModel: ObservableObject {
    
    let httpClient = HTTPClient()
    
    func register(userid: String, password: String) async throws -> RegisterResponseDTO {
        print("userid: \(userid), userpassword: \(password)")
        let registerData = ["user_id": userid, "user_password": password] // 전송할 json 형태
        let resource = try Resource(url: Constants.Urls.register!, method: .post(JSONEncoder().encode(registerData)) ,modelType: RegisterResponseDTO.self)
        let registerResponseDTO = try await httpClient.load(resource)
        return registerResponseDTO
    }

    func login(userid: String, password: String) async throws -> LoginResponseDTO {
        let loginData = ["user_id" : userid, "user_password" : password]
        let resource = try Resource(url: Constants.Urls.login!, method: .post(JSONEncoder().encode(loginData)),modelType: LoginResponseDTO.self)
        let loginResponseDTO = try await httpClient.load(resource)
        return loginResponseDTO
    }
    


}
