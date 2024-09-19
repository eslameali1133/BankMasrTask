//
//  ContentView.swift
//  BankMasrTask
//
//  Created by Eslam ALi on 19/09/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
   

     var body: some View {
       
     //    let cacheManager = CacheManager(context: modelContext)
         let viewModel = MoviesViewModel()

    
         MoviesTabView(viewModel: viewModel)
     }
}

#Preview {
    ContentView()
       
}
