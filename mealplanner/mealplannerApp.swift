//
//  mealplannerApp.swift
//  mealplanner
//
//  Created by Jean Brigonnet on 3/5/23.
//

import SwiftUI

@main
struct mealplannerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(ViewModel())
            
        }
    }
}
