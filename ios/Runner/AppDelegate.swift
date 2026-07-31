import Flutter
import UIKit
import UserNotifications
import WidgetKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self
    }

    if let controller = window?.rootViewController as? FlutterViewController {
      let channel = FlutterMethodChannel(
        name: "vrcn/friend_status_widget",
        binaryMessenger: controller.binaryMessenger
      )
      channel.setMethodCallHandler(handleFriendStatusWidgetCall)
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }

  private func handleFriendStatusWidgetCall(_ call: FlutterMethodCall, result: FlutterResult) {
    let defaults = UserDefaults(suiteName: "group.com.null-base.vrchat")

    switch call.method {
    case "update":
      guard
        let arguments = call.arguments as? [String: Any],
        let friends = arguments["friends"] as? [[String: Any]],
        let data = try? JSONSerialization.data(withJSONObject: friends),
        let payload = String(data: data, encoding: .utf8)
      else {
        result(FlutterError(code: "invalid_arguments", message: "Invalid widget payload", details: nil))
        return
      }

      defaults?.set(payload, forKey: "friendStatusWidgetFriends")
      reloadFriendStatusWidget()
      result(nil)
    case "clear":
      defaults?.removeObject(forKey: "friendStatusWidgetFriends")
      reloadFriendStatusWidget()
      result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func reloadFriendStatusWidget() {
    if #available(iOS 14.0, *) {
      WidgetCenter.shared.reloadTimelines(ofKind: "FriendStatusWidget")
    }
  }
}
