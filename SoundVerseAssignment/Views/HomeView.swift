//
//  HomeView.swift
//  SoundVerseAssignment
//
//  Created by Ansh Hardaha on 18/03/25.
//
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppStateManager
    @StateObject private var viewModel = ChatViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.messages) { message in
                                MessageBubble(message: message)
                                    .padding(.horizontal)
                                    .padding(.vertical, 4)
                            }
                        }
                        .padding(.bottom, 10)
                    }
                    .background(Color(.systemGroupedBackground).ignoresSafeArea())
                    .onChange(of: viewModel.messages.count) { _ in
                        // Auto-scroll to the latest message
                        if let lastMessage = viewModel.messages.last {
                            withAnimation {
                                proxy.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    }
                }
                
                // Chat Input Field
                chatInputField()
                    .safeAreaInset(edge: .bottom) { Color.clear.frame(height: 10) }
            }
            .navigationTitle("Chat")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { appState.isMenuOpen.toggle() }) {
                        Image(systemName: "person.crop.circle")
                            .font(.title)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: NotificationListView()) {
                        Image(systemName: "bell")
                            .font(.title)
                    }
                }
            }
        }
    }
    
    private func chatInputField() -> some View {
        HStack {
            TextField("Type a message...", text: $viewModel.newMessage)
                .padding()
                .background(.white)
                .cornerRadius(20)

            Button(action: viewModel.sendMessage) {
                Image(systemName: "arrow.up.circle.fill")
                    .foregroundColor(.blue)
                    .padding()
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(20, corners: [.topLeft, .topRight])
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AppStateManager.shared)
    }
}
