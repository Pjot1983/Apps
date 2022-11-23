//
//  DependencyInjectionApp.swift
//  DependencyInjection
//
//  Created by Pjot on 23.11.2022.
//

import SwiftUI

@main
struct DependencyInjectionApp: App {
    
    static let dataService = DataServiceProtocol.self
    
    var body: some Scene {
        WindowGroup {
            ContentView(dataService: DependencyInjectionApp.dataService as! DataServiceProtocol)
        }
    }
}
