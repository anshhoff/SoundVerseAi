//
//  NotificationViewModel.swift
//  SoundVerseAssignment
//
//  Created by Ansh Hardaha on 18/03/25.
//
import Combine
import UserNotifications

class NotificationViewModel: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    @Published var notifications: [Notification] = Notification.sampleData
    @Published var selectedNotification: Notification? // Store tapped notification
    
    override init() {
        super.init()
        requestNotificationPermissions()
        setupNotificationCenterDelegate()
    }
    
    func markAsRead(_ notification: Notification) {
        if let index = notifications.firstIndex(where: { $0.id == notification.id }) {
            notifications[index].isRead = true
            objectWillChange.send() // ✅ Ensure UI updates
        }
    }
    
    func sendDummyNotification() {
        print("Sending dummy notification...")
        
        let newNotification = Notification(
            title: "Dummy Notification",
            body: "This is a test notification sent after 5 seconds",
            timestamp: Date(),
            isRead: false
        )
        
        let content = UNMutableNotificationContent()
        content.title = newNotification.title
        content.body = newNotification.body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Dummy notification scheduled successfully")
                
                // Get pending notifications for verification
                UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
                    print("Pending notifications: \(requests.count)")
                    for req in requests {
                        print("Scheduled notification: \(req.identifier) - \(req.content.title)")
                    }
                }
            }
        }
    }

    private func requestNotificationPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("✅ Notification permissions granted")
            } else if let error = error {
                print("❌ Notification permissions error: \(error.localizedDescription)")
            }
        }
    }
    
    private func setupNotificationCenterDelegate() {
        UNUserNotificationCenter.current().delegate = self
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Notification received while app is in foreground: \(notification.request.content.title)")
        
        // Show notification alert even when app is in foreground
        completionHandler([.alert, .sound])
        
        // Add the notification to your list
        let newNotification = Notification(
            title: notification.request.content.title,
            body: notification.request.content.body,
            timestamp: Date(),
            isRead: false
        )
        notifications.insert(newNotification, at: 0)
    }
}
