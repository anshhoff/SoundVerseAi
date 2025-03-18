//
//  Notification.swift
//  SoundVerseAssignment
//
//  Created by Ansh Hardaha on 18/03/25.
//

import Foundation

struct Notification: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let body: String
    let timestamp: Date
    var isRead: Bool

    // Conforming to Equatable
    static func == (lhs: Notification, rhs: Notification) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Notification {
    static var sampleData: [Notification] = [
        Notification(title: "New Message", body: "You have a new message from Soundverse", timestamp: Date(timeIntervalSinceNow: -3600), isRead: false),
        Notification(title: "Update Available", body: "A new version of Soundverse is available", timestamp: Date(timeIntervalSinceNow: -7200), isRead: false),
        Notification(title: "Feature Announcement", body: "We've added new profile customization options", timestamp: Date(timeIntervalSinceNow: -21600), isRead: true)
    ]
}

