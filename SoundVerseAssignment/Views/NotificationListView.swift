//
//  NotificationListView.swift
//  SoundVerseAssignment
//
//  Created by Ansh Hardaha on 18/03/25.
//

import SwiftUI

struct NotificationRow: View {
    let notification: Notification
    @EnvironmentObject var viewModel: NotificationViewModel
    
    var body: some View {
        NavigationLink(destination: NotificationDetailView(notification: notification)) {
                   HStack(alignment: .top, spacing: 12) {
                       Image(systemName: notification.isRead ? "bell.fill" : "bell.badge")
                           .foregroundColor(notification.isRead ? .gray : .blue)
                           .font(.title2)
                       
                       VStack(alignment: .leading, spacing: 6) {
                           Text(notification.title)
                               .font(.headline)
                               .foregroundColor(notification.isRead ? .gray : .primary)
                           
                           Text(notification.body)
                               .font(.subheadline)
                               .foregroundColor(notification.isRead ? .gray : .secondary)
                               .lineLimit(2)

                           Text(timeAgoSinceNow(date: notification.timestamp))
                               .font(.caption)
                               .foregroundColor(.gray)
                       }
                       
                       Spacer()
                   }
                   .padding(.vertical, 10)
                   .padding(.horizontal, 15)
                   .background(.ultraThinMaterial)
                   .cornerRadius(12)
               }
               .onTapGesture {
                   viewModel.markAsRead(notification)
               }
           }
    
    private func timeAgoSinceNow(date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}

struct NotificationListView: View {
    @StateObject private var viewModel = NotificationViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                // 🔹 Test Button
                Button(action: {
                    viewModel.sendDummyNotification()
                }) {
                    Text("Send Test Notification")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(viewModel.notifications) { notification in
                            NotificationRow(notification: notification)
                                .environmentObject(viewModel)
                                .transition(.slide)
                        }
                    }
                    .padding()
                }
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                }
            }
            .onChange(of: viewModel.selectedNotification) { newNotification in
                if let newNotification = newNotification {
                    navigateToDetail(notification: newNotification)
                }
            }
        }
    }
    
    /// 🔹 Function to navigate when a notification is tapped
    private func navigateToDetail(notification: Notification) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            
            let rootView = NotificationDetailView(notification: notification)
            window.rootViewController = UIHostingController(rootView: rootView)
            window.makeKeyAndVisible()
        }
    }
}

#Preview {
    NotificationListView()
}



