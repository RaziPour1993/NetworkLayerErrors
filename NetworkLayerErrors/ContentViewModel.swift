//
//  ContentViewModel.swift
//  NetworkLayerErrors
//
//  Created by Mohammad Razipour on 7/19/24.
//

import Foundation
import Combine

@MainActor
class ContentViewModel: ObservableObject {
    
    @Published var data: Data?
    @Published var errorMessage: String?
    
    func fetchData() {
        Task {
            let result = await NetworkManager.shared.performRequest(url: URL(string: "https://www.time.ir/")!)
            switch result {
            case .success(let success):
                self.data = success
            case .failure(let failure):
                self.errorMessage = failure.description
            }
        }
    
    }
    
}
