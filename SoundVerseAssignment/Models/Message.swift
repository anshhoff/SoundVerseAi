//
//  Message.swift
//  SoundVerseAssignment
//
//  Created by Ansh Hardaha on 18/03/25.
//


import Foundation

struct Message: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isCurrentUser: Bool
    let timestamp: Date
}

extension Message {
    static var sampleData: [Message] = [
        Message(text: "Hello! How are you?", isCurrentUser: false, timestamp: Date(timeIntervalSinceNow: -600)),
        Message(text: "I'm doing well, thanks!", isCurrentUser: true, timestamp: Date(timeIntervalSinceNow: -500)),
        Message(text: "That's great to hear!", isCurrentUser: false, timestamp: Date(timeIntervalSinceNow: -400)),
        Message(text: "What are you working on?", isCurrentUser: true, timestamp: Date(timeIntervalSinceNow: -300)),
        Message(text: "Just this iOS assignment actually", isCurrentUser: false, timestamp: Date(timeIntervalSinceNow: -200))
    ]
}
