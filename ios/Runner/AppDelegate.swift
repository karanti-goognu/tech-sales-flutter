import UIKit
import Flutter
import Firebase
import GoogleMaps
import moengage_flutter
import MoEngage

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  MoEngage.setAppGroupID("group.com.alphadevs.MoEngage.NotificationServices")
  MOFlutterInitializer.sharedInstance.initializeWithAppID("6XHHUKUOKFE6Q5MLTT8UH5RW", withLaunchOptions: launchOptions)
  FirebaseApp.configure()
  GMSServices.provideAPIKey("AIzaSyC8GcSwDzPq7gW_vKmsTNv9Xqr9WvwfA5E")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
