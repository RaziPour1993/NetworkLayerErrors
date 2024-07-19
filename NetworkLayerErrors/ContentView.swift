//
//  ContentView.swift
//  NetworkLayerErrors
//
//  Created by Mohammad Razipour on 7/19/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            if viewModel.data != nil {
                Text("Data loaded successfully")
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            } else {
                Text("Loading...")
            }
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
    
}

#Preview {
    ContentView()
}
