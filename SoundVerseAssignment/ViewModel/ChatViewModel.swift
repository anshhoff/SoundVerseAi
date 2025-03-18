//
//  ChatViewModel.swift
//  SoundVerseAssignment
//
//  Created by Ansh Hardaha on 18/03/25.
//


import Combine
import Foundation

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = Message.sampleData
    @Published var newMessage = ""
    
    func sendMessage() {
        guard !newMessage.isEmpty else { return }
        
        let newMessage = Message(text: newMessage, isCurrentUser: true, timestamp: Date())
        messages.append(newMessage)
        self.newMessage = ""
    }
}
