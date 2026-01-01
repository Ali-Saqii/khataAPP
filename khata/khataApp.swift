//
//  khataApp.swift
//  khata
//
//  Created by Mac mini on 30/12/2025.
//

import SwiftUI

@main
struct khataApp: App {
    
    @StateObject var viewModel:HomeViewModel = HomeViewModel()
    
    
    var body: some Scene {
        WindowGroup {
       ContentView()
        }
    }
}
