//
//  khataApp.swift
//  khata
//
//  Created by Mac mini on 30/12/2025.
//

import SwiftUI

@main
struct KhataApp: App {
    @StateObject private var homeVM = HomeViewModel()

    var body: some Scene {
        WindowGroup {
            HomwView()
                .environmentObject(homeVM)
        }
    }
}

