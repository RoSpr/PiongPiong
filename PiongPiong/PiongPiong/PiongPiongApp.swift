//
//  PiongPiongApp.swift
//  PiongPiong
//
//  Created by Rodion on 05/10/2025.
//

import SwiftUI

@main
struct PiongPiongApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: TableViewModel())
                .preferredColorScheme(.light)
        }
    }
}
