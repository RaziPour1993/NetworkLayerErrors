//
//  NetworkManager.swift
//  NetworkLayerErrors
//
//  Created by Mohammad Razipour on 7/19/24.
//

import Foundation

struct NetworkManager {
    
    private struct NetworkError: Codable {
        let error: String?
    }
    
    static let shared = NetworkManager()
    private init() {}
    
    func performRequest(url: URL) async -> Result<Data, NetworkResponseStatus> {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(NetworkResponseStatus(statusCode: nil, message: "Invalid response"))
            }
            
            let networkResponseStatus = NetworkResponseStatus(statusCode: httpResponse.statusCode)
            
            switch networkResponseStatus {
            case .success(let status, _):
                if status == .ok {
                    return .success(data)
                } else {
                    return .failure(networkResponseStatus)
                }
            default:
                let decoder = JSONDecoder()
                if let model = try? decoder.decode(NetworkError.self, from: data) {
                    return .failure(NetworkResponseStatus(statusCode: httpResponse.statusCode, message: model.error))
                }
                return .failure(networkResponseStatus)
            }
            
        } catch {
            return .failure(.internalStatus(status: .internetAccessError))
        }
        
    }
}
