import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let urlChannel = FlutterMethodChannel(name: "schuly/url_launcher",
                                          binaryMessenger: controller.binaryMessenger)
    
    urlChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
      switch call.method {
      case "launchEmail":
        if let args = call.arguments as? [String: Any],
           let email = args["email"] as? String {
          let subject = args["subject"] as? String
          let launched = self.launchEmail(email: email, subject: subject)
          result(launched)
        } else {
          result(FlutterError(code: "INVALID_ARGUMENT", message: "Email cannot be null", details: nil))
        }
      case "launchUrl":
        if let args = call.arguments as? [String: Any],
           let url = args["url"] as? String {
          let launched = self.launchUrl(url: url)
          result(launched)
        } else {
          result(FlutterError(code: "INVALID_ARGUMENT", message: "URL cannot be null", details: nil))
        }
      default:
        result(FlutterMethodNotImplemented)
      }
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  private func launchEmail(email: String, subject: String?) -> Bool {
    var mailtoString = "mailto:\(email)"
    if let subject = subject {
      let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? subject
      mailtoString += "?subject=\(encodedSubject)"
    }
    
    guard let url = URL(string: mailtoString) else { return false }
    
    if UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
      return true
    }
    return false
  }
  
  private func launchUrl(url: String) -> Bool {
    guard let url = URL(string: url) else { return false }
    
    if UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
      return true
    }
    return false
  }
}
