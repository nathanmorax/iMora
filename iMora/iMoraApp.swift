//
//  iMoraApp.swift
//  iMora
//
//  Created by Jonathan Mora on 17/05/25.
//

import SwiftUI

@main
struct iMoraApp: App {
    /*init() {
           _ = NetworkMonitor.shared
       }*/
    var body: some Scene {
       
        WindowGroup {
            if #available(iOS 26.0, *) {
                CoordinatorView()
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
