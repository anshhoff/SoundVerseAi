//
//  AppStateManager.swift
//  SoundVerseAssignment
//
//  Created by Ansh Hardaha on 18/03/25.
//


import SwiftUI
import Combine

class AppStateManager: ObservableObject {
    @Published var currentView: String = "home"
    @Published var isMenuOpen = false
    
    static let shared = AppStateManager()
    
    private init() {}
}