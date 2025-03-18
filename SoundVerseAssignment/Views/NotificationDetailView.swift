//
//  NotificationDetailView.swift
//  SoundVerseAssignment
//
//  Created by Ansh Hardaha on 18/03/25.
//

import SwiftUI

struct NotificationDetailBubble: View {
    let text: String
    let isCurrentUser: Bool
    
    var body: some View {
        HStack {
            if isCurrentUser {
                Spacer()
            }
            
            Text(text)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(isCurrentUser ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(isCurrentUser ? .white : .primary)
                .cornerRadius(15)
            
            if !isCurrentUser {
                Spacer()
            }
        }
    }
}

struct NotificationDetailView: View {
    let notification: Notification
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 12) {
                    NotificationDetailBubble(text: "System: \(notification.title)", isCurrentUser: false)
                    NotificationDetailBubble(text: notification.body, isCurrentUser: false)
                }
                .padding()
            }
        }
        .navigationTitle("Notification")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    NotificationDetailView(notification: Notification.sampleData[0])
}
