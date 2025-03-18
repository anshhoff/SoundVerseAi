//
//  ContentView.swift
//  SoundVerseAssignment
//
//  Created by Ansh Hardaha on 18/03/25.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @StateObject private var appState = AppStateManager.shared
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Main content
                NavigationStack {
                    HomeView()
                        .environmentObject(appState)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .offset(x: appState.isMenuOpen ? geometry.size.width * 0.7 : 0)
                .animation(.easeInOut(duration: 0.3), value: appState.isMenuOpen)
                .gesture(
                    DragGesture()
                        .onEnded { gesture in
                            if gesture.translation.width > 50 {
                                withAnimation { appState.isMenuOpen = true }
                            }
                        }
                )
                
                // Side menu
                SideMenuView()
                    .environmentObject(appState)
                    .frame(width: geometry.size.width * 0.7)
                    .offset(x: appState.isMenuOpen ? 0 : -geometry.size.width * 0.7)
                    .animation(.easeInOut(duration: 0.3), value: appState.isMenuOpen)
                    .gesture(
                        DragGesture()
                            .onEnded { gesture in
                                if gesture.translation.width < -50 {
                                    withAnimation { appState.isMenuOpen = false }
                                }
                            }
                    )
                    .zIndex(1)
                
                // Dim overlay
                Color.black.opacity(appState.isMenuOpen ? 0.4 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .animation(.easeInOut(duration: 0.5), value: appState.isMenuOpen)
                    .onTapGesture {
                        withAnimation { appState.isMenuOpen = false }
                    }
                    .zIndex(0)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            requestNotificationPermissions()
        }
    }
    
    private func requestNotificationPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Notification permissions granted")
            } else if let error = error {
                print("Notification permissions error: \(error.localizedDescription)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppStateManager.shared)
    }
}
