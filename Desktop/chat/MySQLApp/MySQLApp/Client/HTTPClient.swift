//
//  HTTPSignInClient.swift
//  CurrentMovie
//
//  Created by Taewon Yoon on 2023/07/09.
//

import Foundation
import UserNotifications
import UIKit


protocol loginAlert {
    func makeNotification()
}

//MARK: 에러 다루는 곳
enum NetworkError: Error {
    case badRequest
    case serverError(String)
    case decodingError
    case invalidResponse
}

extension NetworkError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
            case .badRequest:
                return NSLocalizedString("Unable to perform request", comment: "badRequestError")
            case .serverError(let errorMessage):
                return NSLocalizedString(errorMessage, comment: "serverError")
            case .decodingError:
                return NSLocalizedString("Unable to decode successfully.", comment: "decodingError")
            case .invalidResponse:
                return NSLocalizedString("Invalid response", comment: "invalidResponse")
        }
    }
    
}
//MARK: HTTPMethod
enum HTTPMethod {
    case getnothing
    case get([URLQueryItem])
    case post(Data?)
    case delete
    
    var name: String {
        switch self {
        case .get, .getnothing:
                return "GET"
            case .post:
                return "POST"
            case .delete:
                return "DELETE"
        }
    }
}
//MARK: 가져올 리소스 형태를 만듬
struct Resource<T: Codable> {
    let url: URL
    var method: HTTPMethod = .get([]) // 열거형 get을 사용한다.
    var modelType: T.Type // 가져올 데이터의 타입
}


struct HTTPClient {
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T {
        
        var request = URLRequest(url: resource.url)
        
        switch resource.method {
            case .getnothing:
                break
            
            case .get(let queryItems): //
            
                var components = URLComponents(url: resource.url, resolvingAgainstBaseURL: false) // URL을 구성하는 구조
                components?.queryItems = queryItems // http://127.0.0.1:8080/...?queryItems=\(queryItems값)이다.
                guard let url = components?.url else {
                        throw NetworkError.badRequest
                }
                print(url)
            
                request = URLRequest(url: url)
                
            case .post(let data):
                request.httpMethod = resource.method.name
                request.httpBody = data
            
            case .delete:
                request.httpMethod = resource.method.name
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"] // 토큰이 있으면 사용해야한다.
//        configuration.
        let session = URLSession(configuration: configuration)
        let (data, response) = try await session.data(for: request)
        
        
        guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
        }
        switch httpResponse.statusCode {
            case 409:
            
                throw NetworkError.serverError("Username is already taken.")
            default:
                break
        }
        // 데이터를 decode하는 곳이다.
        do {
            print(resource.modelType.self)
            let result = try JSONDecoder().decode(resource.modelType, from: data)
            
            // 디코딩 성공 시 처리
        } catch let decodingError as DecodingError {
            // 디코딩 에러 처리
            switch decodingError {
            case .dataCorrupted(let context):
                print("Data Corrupted: \(context)")
            case .keyNotFound(let key, let context):
                print("Key Not Found: \(key), Context: \(context)")
            case .typeMismatch(let type, let context):
                print("Type Mismatch: \(type), Context: \(context)")
            case .valueNotFound(let type, let context):
                print("Value Not Found: \(type), Context: \(context)")
            @unknown default:
                print("Unknown Decoding Error")
            }
            throw NetworkError.decodingError
        } catch {
            // 다른 에러 처리
            print("Unexpected Error: \(error)")
            throw NetworkError.decodingError
        }
        
        print(data.description)

        let result = try JSONDecoder().decode(resource.modelType, from: data)
        
        
        // decode한 값을 반환한다.
        return result
    }
    

    
}
