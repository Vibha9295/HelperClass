//
// NotificationDelegate.swift
//

class NotificationDelegate: NSObject , UNUserNotificationCenterDelegate {
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo as NSDictionary
        
        notificationNavigation(notificationData: userInfo)
        
        completionHandler([.alert,.sound])
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo as NSDictionary
        
        notificationNavigation(notificationData: userInfo)
    }
    
    //MARK: - Notification Navigation Method
    func notificationNavigation(notificationData : NSDictionary) {
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        Utility().setRootGoodNewsVC()
    }
}


