//
//  SideMenuView.swift
//  SoundVerseAssignment
//
//  Created by Ansh Hardaha on 18/03/25.
//

import SwiftUI

struct SideMenuView: View {
    @EnvironmentObject var appState: AppStateManager

    var body: some View {
        ZStack(alignment: .leading) {
            Color(.systemGray6)
                .edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading, spacing: 20) {
                // Profile section
                VStack(alignment: .leading) {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)

                    Text("Soundverse")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                .padding(.top, 60)
                .padding(.leading)

                Divider()

                // Menu items
                VStack(alignment: .leading, spacing: 20) {
                    SideMenuButton(title: "Home", icon: "house") {
                        changeView(to: "home")
                    }

                    SideMenuButton(title: "Notifications", icon: "bell") {
                        changeView(to: "notifications")
                    }

                    SideMenuButton(title: "Profile", icon: "person.crop.circle") {
                        changeView(to: "profile")
                    }
                }
                .padding(.leading)

                Spacer()
            }
            
        }
        .frame(width: UIScreen.main.bounds.width * 0.75)
        .transition(.move(edge: .leading))
        
    }

    private func changeView(to view: String) {
        withAnimation {
            appState.currentView = view
            appState.isMenuOpen = false
        }
    }
}

// Custom Button for Menu Items
struct SideMenuButton: View {
    let title: String
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.title3)
                Text(title)
                    .font(.headline)
            }
            .foregroundColor(.primary)
            .padding(.vertical, 10)
        }
    }
}

#Preview {
    SideMenuView()
        .environmentObject(AppStateManager.shared) // ✅ Prevents preview crash
}
