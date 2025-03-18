//
//  MenuViewModel.swift
//  SoundVerseAssignment
//
//  Created by Ansh Hardaha on 18/03/25.
//


import Combine

class MenuViewModel: ObservableObject {
    @Published var isMenuOpen = false
    
    func toggleMenu() {
        isMenuOpen.toggle()
    }
}