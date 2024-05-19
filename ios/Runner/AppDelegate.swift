import UIKit
import Flutter
import GoogleMaps            

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyB_cU9Y_M2Hz7NhVhbOWWqjp4Pdi5jCNA0")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}


