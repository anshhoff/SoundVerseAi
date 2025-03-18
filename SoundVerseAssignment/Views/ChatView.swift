//
//  ChatView.swift
//  SoundVerseAssignment
//
//  Created by Ansh Hardaha on 18/03/25.
//

import SwiftUI

struct MessageBubble: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.isCurrentUser {
                Spacer()
            }
            
            Text(message.text)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(message.isCurrentUser ? Color.purple : Color.white.opacity(1))
                .foregroundColor(message.isCurrentUser ? .white : .primary)
                .cornerRadius(15)
            
            if !message.isCurrentUser {
                Spacer()
            }
        }
    }
}

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var newMessage = ""
    @EnvironmentObject var menuViewModel: MenuViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.messages) { message in
                        MessageBubble(message: message)
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                    }
                }
                .padding(.bottom, 100) // Space for input field
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            
            // Input field
            HStack {
                TextField("Type a message...", text: $newMessage)
                    .padding()
                    .background(.white)
                    .cornerRadius(20)
                
                Button(action: sendMessage) {
                    Image(systemName: "arrow.up.circle.fill")
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(20, corners: [.topLeft, .topRight])
            .padding(.bottom, 30)
        }
        .navigationTitle("Chat")
        .toolbar {
            // Profile icon (left)
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { menuViewModel.toggleMenu() }) {
                    Image(systemName: "person.crop.circle")
                        .font(.title)
                }
            }
            
            // Notification bell (right)
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: NotificationListView()) {
                    Image(systemName: "bell")
                        .font(.title)
                }
            }
        }
    }
    
    private func sendMessage() {
        viewModel.sendMessage()
        newMessage = ""
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
            .environmentObject(MenuViewModel())
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    ChatView()
}
