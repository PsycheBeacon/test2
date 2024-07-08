//
//  test2App.swift
//  test2
//
//  Created by Michelle Hou on 7/7/24.
//

import SwiftUI

@main
struct test2App: App {
    @StateObject var manager = HealthManager()
    var body: some Scene {
        WindowGroup {
            MyTabView()
                .environmentObject(manager)
        }
    }
}
