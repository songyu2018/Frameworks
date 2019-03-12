/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import SafariServices
import UserNotifications

enum Identifiers {
  static let viewAction = "VIEW_IDENTIFIER"
  static let newsCategory = "NEWS_CATEGORY"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions
    launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    UNUserNotificationCenter.current().delegate = self
    
    //UITabBar.appearance().barTintColor = .themeGreenColor
    UITabBar.appearance().tintColor = .white
    
    registerForPushNotifications()
    
    // Check if launched from notification
    let notificationOption = launchOptions?[.remoteNotification]
    
    // 1
    if let notification = notificationOption as? [String: AnyObject],
        let _ = notification["aps"] as? [String: AnyObject] {
      
      // 2
      //_ = NewsItem.makeNewsItem(aps)
      
      // 3
      (window?.rootViewController as? UITabBarController)?.selectedIndex = 1
    }
    
    return true
  }
  
  func registerForPushNotifications() {
    UNUserNotificationCenter.current()
      .requestAuthorization(options: [.alert, .sound, .badge]) {
        [weak self] granted, error in
        guard let self = self else { return }
        print("Permission granted: \(granted)")
        
        guard granted else { return }
        
        // 1
        let viewAction = UNNotificationAction(
          identifier: Identifiers.viewAction, title: "View",
          options: [.foreground])
        
        // 2
        let newsCategory = UNNotificationCategory(
          identifier: Identifiers.newsCategory, actions: [viewAction],
          intentIdentifiers: [], options: [])
        
        // 3
        UNUserNotificationCenter.current()
          .setNotificationCategories([newsCategory])
        
        self.getNotificationSettings()
    }
  }
  
  func getNotificationSettings() {
    UNUserNotificationCenter.current().getNotificationSettings { settings in
      print("Notification settings: \(settings)")
      guard settings.authorizationStatus == .authorized else { return }
      DispatchQueue.main.async {
        UIApplication.shared.registerForRemoteNotifications()
      }
    }
  }
  
  func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    
    let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
    let token = tokenParts.joined()
    print("Device Token: \(token)")
  }
  
  func application(
    _ application: UIApplication,
    didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("Failed to register: \(error)")
  }
  
  func application(
    _ application: UIApplication,
    didReceiveRemoteNotification userInfo: [AnyHashable: Any],
    fetchCompletionHandler completionHandler:
    @escaping (UIBackgroundFetchResult) -> Void) {
    
    guard let aps = userInfo["aps"] as? [String: AnyObject] else {
      completionHandler(.failed)
      return
    }
    
    
    if aps["content-available"] as? Int == 1 {
      // Logic with the silent PN.
    } else  {
      // Logic with the normal PN.
    }
  }
}

// MARK: - UNUserNotificationCenterDelegate
// Notificaion ACTION handler.
extension AppDelegate: UNUserNotificationCenterDelegate {
  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void) {
    /*
    // 1
    let userInfo = response.notification.request.content.userInfo
    
    // 2
    
    if let aps = userInfo["aps"] as? [String: AnyObject],
        

      let newsItem = NewsItem.makeNewsItem(aps) {
      
      (window?.rootViewController as? UITabBarController)?.selectedIndex = 1
      
      // 3
      if response.actionIdentifier == Identifiers.viewAction,
        let url = URL(string: newsItem.link) {
        let safari = SFSafariViewController(url: url)
        window?.rootViewController?.present(safari, animated: true,
                                            completion: nil)
      }

    }
    
    // 4
    completionHandler()
 */
  }
 
}
