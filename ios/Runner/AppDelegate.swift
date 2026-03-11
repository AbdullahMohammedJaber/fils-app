import Flutter
import UIKit

import FirebaseCore
import flutter_local_notifications  // ← مطلوب لـ setPluginRegistrantCallback




@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // ─── flutter_local_notifications (Background Isolate) ─────────────────
    // مطلوب لتشغيل الإشعارات في الخلفية على iOS
  
    // ─────────────────────────────────────────────────────────────────────

    // ─── Local Notifications delegate (iOS 10+) ───────────────────────────
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self
    }
    // ─────────────────────────────────────────────────────────────────────

    

    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}